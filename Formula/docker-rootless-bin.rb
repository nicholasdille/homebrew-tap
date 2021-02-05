class DockerRootlessBin < Formula
  desc "Rootless tools for Docker CLI"
  homepage "https://www.docker.com"
  license "Apache-2.0"

  if Hardware::CPU.intel?
    url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.3.tgz"
    sha256 "6a7e2fe34112dfdbec619af4ca4db877133b29f245475df099e812d0d75e8eb5"
  else
    odie "Only amd64 is supported"
  end

  bottle :unneeded

  depends_on "nicholasdille/tap/docker-bin"

  conflicts_with "nicholasdille/tap/rootlesskit"
  conflicts_with "nicholasdille/tap/rootlesskit-bin"

  def install
    bin.install "rootlesskit"
    bin.install "rootlesskit-docker-proxy"
    bin.install "vpnkit"
    bin.install "dockerd-rootless-setuptool.sh"
    bin.install "dockerd-rootless.sh"
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
