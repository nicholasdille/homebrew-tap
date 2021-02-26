class DockerdBin < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.3.tgz"
  sha256 "47065a47f0692cd5af03073c7386fe090d9ef5ac88a7d8455a884d8e15809be5"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/runc"
  depends_on "nicholasdille/tap/slirp4netns"

  resource "dockerd-rootless.sh" do
    url "https://github.com/moby/moby/raw/v20.10.3/contrib/dockerd-rootless.sh"
    sha256 "5dd61047cf0925fae90de142c03d85c776ff0d56ceb2e1bd4841d26c0a3bde72"
  end

  def install
    bin.install "docker-init"
    bin.install "docker-proxy"
    bin.install "dockerd"

    resource("dockerd-rootless.sh").stage do
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
