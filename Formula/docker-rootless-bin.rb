class DockerRootlessBin < Formula
  desc "Rootless tools for Docker CLI"
  homepage "https://www.docker.com"
  if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.3.tgz"
    sha256 "6a7e2fe34112dfdbec619af4ca4db877133b29f245475df099e812d0d75e8eb5"
  elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://download.docker.com/linux/static/stable/aarch64/docker-rootless-extras-20.10.3.tgz"
    sha256 "2a88fdfac090183e7ec545b3141dff0af60d1366bafb37a7bb3037bd7578c377"
  elsif Hardware::CPU.ppc64le?
    url "https://download.docker.com/linux/static/stable/ppc64le/docker-rootless-extras-20.10.3.tgz"
    sha256 "b05a3ed06f27e258e637aec11b081da2de1e02173c81293aa29f83e00a794b98"
  else
    odie "Processor architecture is not supported."
  end
  version "20.10.3"
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
    system "#{bin}/docker", "--version"
  end
end
