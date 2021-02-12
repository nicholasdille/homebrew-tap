class DockerdBin < Formula
  desc "Docker daemon"
  homepage "https://www.docker.com"

  url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.2.tgz"
  sha256 "97017e32a8ecbdd1826bb3c7b1424303ee0dea3f900d33591b1df5e394ed4eed"
  license "Apache-2.0"

  bottle :unneeded

  resource "docker-rootless-extras" do
    url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.2.tgz"
    sha256 "4ebdad1d4743ccca68d183fccdb978aa8b62e7b24743fff36099bd29e46380e0"
  end

  option "with-dockerd", "Install Docker daemon"

  conflicts_with "docker", because: "both install `docker` binary"
  if build.with? "dockerd"
    depends_on "immortal"
    conflicts_with "nicholasdille/tap/runc"
    conflicts_with "nicholasdille/tap/runc-bin"
    conflicts_with "nicholasdille/tap/containerd"
    conflicts_with "nicholasdille/tap/containerd-bin"
  end

  def install
    bin.install "docker"

    if build.with? "dockerd"
      bin.install "runc"
      bin.install "containerd"
      bin.install "containerd-shim"
      bin.install "containerd-shim-runc-v2"
      bin.install "ctr"
      bin.install "docker-init"
      bin.install "docker-proxy"
      bin.install "dockerd"

      resource("docker-rootless-extras").stage {
        bin.install "rootlesskit"
        bin.install "rootlesskit-docker-proxy"
        bin.install "vpnkit"
        bin.install "dockerd-rootless-setuptool.sh"
        bin.install "dockerd-rootless.sh"
      }

      (buildpath/"daemon.json").write <<~EOS
        {
          "features": {
            "buildkit": true
          }
        }
      EOS
      (etc/"docker").install "daemon.json"

      (buildpath/"dockerd.yaml").write <<~EOS
        cmd: dockerd --config-file #{etc}/docker/daemon.json --host #{var}/run/docker.sock --containerd=/run/containerd/sock
        cwd: #{etc/"docker"}
        pid:
            follow: #{var}/run/dockerd/unicorn.pid
            parent: #{var}/run/dockerd/parent.pid
            child: #{var}/run/dockerd/child.pid
        log:
            file: #{var}/var/log/dockerd.log
            age: 86400
            num: 7
            size: 1
            timestamp: true
        logger: logger -t dockerd
        user: root
        wait: 1
      EOS
      (etc/"immortal").install "dockerd.yaml"
    end
  end

  test do
    system "#{bin}/docker", "--version"

    system "#{bin}/dockerd", "--version" if build.with? "dockerd"
  end
end
