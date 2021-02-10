class DockerRootlessBin < Formula
  desc "Rootless tools for Docker CLI"
  homepage "https://www.docker.com"
  if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.2.tgz"
    sha256 "4ebdad1d4743ccca68d183fccdb978aa8b62e7b24743fff36099bd29e46380e0"
  elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/aarch64/docker-rootless-extras-20.10.2.tgz"
    sha256 "6f0971ad9e27278a4afefa0999aeb6768f7071a0737fc527db89179fe22ebc44"
  elsif Hardware::CPU.ppc64le?
    url "https://download.docker.com/linux/static/stable/ppc64le/docker-rootless-extras-20.10.2.tgz"
    sha256 "0444610e911f6910f9a4a9d8addab5e4dafe8eea7204c25fe4c174e9b77442fe"
  else
    odie "Processor architecture is not supported."
  end
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
