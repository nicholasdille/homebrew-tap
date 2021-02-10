class DockerRootlessBin < Formula
  desc "Rootless tools for Docker CLI"
  homepage "https://www.docker.com"
  url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.2.tgz"
  sha256 "4ebdad1d4743ccca68d183fccdb978aa8b62e7b24743fff36099bd29e46380e0"
  license "Apache-2.0"

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
    system "#{bin}/rootlesskit", "--version"
  end
end
