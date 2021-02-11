class RootlesskitBin < Formula
  desc "Linux-native 'fake root' for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"
  
  url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.0/rootlesskit-x86_64.tar.gz"
  version "0.13.0"
  sha256 "6c7422729bb4c7adaed96e30e9f9145f955e1c71296cab97ee419b43ec5a31fa"
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
