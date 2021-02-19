class DockerdBin < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.2.tgz"
  sha256 "97017e32a8ecbdd1826bb3c7b1424303ee0dea3f900d33591b1df5e394ed4eed"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/runc"
  depends_on "nicholasdille/tap/slirp4netns"

  resource "docker-rootless-extras" do
    url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.2.tgz"
    sha256 "4ebdad1d4743ccca68d183fccdb978aa8b62e7b24743fff36099bd29e46380e0"
  end

  def install
    bin.install "docker-init"
    bin.install "docker-proxy"
    bin.install "dockerd"

    resource("docker-rootless-extras").stage do
      bin.install "dockerd-rootless-setuptool.sh"
      bin.install "dockerd-rootless.sh"
    end

    (buildpath/"daemon.json").write <<~EOS
      {
        "features": {
          "buildkit": true
        }
      }
    EOS
    (etc/"docker").install "daemon.json"

    (var/"run/dockerd").mkpath
    (var/"log").mkpath
    (buildpath/"dockerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/dockerd-rootless.sh --config-file #{etc}/docker/daemon.json
      cwd: #{etc}/docker
      env:
        XDG_RUNTIME_DIR: #{var}/run/dockerd
      pid:
        parent: #{var}/run/dockerd/parent.pid
        child: #{var}/run/dockerd/child.pid
      log:
        file: #{var}/log/dockerd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "dockerd.yml"
  end

  test do
    system "#{bin}/dockerd", "--version"
  end
end
