class DockerBin < Formula
  desc "Docker CLI"
  homepage "https://www.docker.com"
  if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.3.tgz"
    sha256 "47065a47f0692cd5af03073c7386fe090d9ef5ac88a7d8455a884d8e15809be5"
  elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/aarch64/docker-20.10.3.tgz"
    sha256 "4dcd105f721297f314bb53622e67dd981a743d72f4b2bfe4f42a8790e0892c82"
  elsif Hardware::CPU.ppc64le?
    url "https://download.docker.com/linux/static/stable/ppc64le/docker-20.10.3.tgz"
    sha256 "f88dd3635386d6e658ca970f8442fff97981e2239d2cf88b62e94d4302539f52"
  else
    odie "Processor architecture is not supported."
  end
  version "20.10.3"
  license "Apache-2.0"

  bottle :unneeded

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
          follow: #{var}/run/docker/unicorn.pid
          parent: #{var}/run/docker/parent.pid
          child: #{var}/run/docker/child.pid
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
  end
end
