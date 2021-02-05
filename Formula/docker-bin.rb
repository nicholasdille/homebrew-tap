class DockerBin < Formula
  desc "Docker CLI"
  homepage "https://www.docker.com"
  license "Apache-2.0"

  if Hardware::CPU.intel?
    url "https://download.docker.com/linux/static/stable/x86_64/docker-20.10.3.tgz"
    sha256 "47065a47f0692cd5af03073c7386fe090d9ef5ac88a7d8455a884d8e15809be5"
  else
    odie "Only amd64 is supported"
  end

  bottle :unneeded

  option "with-dockerd", "Install Docker daemon"

  conflicts_with "docker", because: "both install `docker` binary"
  if build.with? "dockerd"
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
    end
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
