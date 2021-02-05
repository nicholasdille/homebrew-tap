class RootlesskitBin < Formula
  desc "Linux-native 'fake root' for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"
  if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
    url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.0/rootlesskit-x86_64.tar.gz"
    sha256 "6c7422729bb4c7adaed96e30e9f9145f955e1c71296cab97ee419b43ec5a31fa"
  elsif Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.0/rootlesskit-aarch64.tar.gz"
    sha256 "94b8bdd9addcea0e9f501fbf99da170ae2836e4346871fb0a537fe7b5c17bb02"
  elsif Hardware::CPU.ppc64le?
    url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.0/rootlesskit-ppc64le.tar.gz"
    sha256 "b9642625d10234d551e29f0ba2b2cdf659a831c9f0806da7a2f6bc14a8ce1ceb"
  else
    odie "Processor architecture is not supported."
  end
  version "0.13.0"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/rootlesskit"

  def install
    bin.install "rootlesskit"
    bin.install "rootlessctl"
    bin.install "rootlesskit-docker-proxy"
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
