class ContainerdBin < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io/"
  url "https://github.com/containerd/containerd/releases/download/v1.4.3/containerd-1.4.3-linux-amd64.tar.gz"
  sha256 "34a161e3f459fd337b03141a339eeb1a56c5c811922fe72012d2dac9fa5542f1"
  version "1.4.3"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/containerd"

  def install
    bin.install "containerd"
    bin.install "containerd-shim"
    bin.install "containerd-shim-runc-v1"
    bin.install "containerd-shim-runc-v2"
    bin.install "ctr"
  end

  test do
    system "#{bin}/docker", "--version"
  end
end
