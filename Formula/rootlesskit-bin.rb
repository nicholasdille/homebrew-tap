class RootlesskitBin < Formula
  desc "Linux-native 'fake root' for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"
  license "Apache-2.0"

  if Hardware::CPU.intel?
    url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.0/rootlesskit-x86_64.tar.gz"
    sha256 "6c7422729bb4c7adaed96e30e9f9145f955e1c71296cab97ee419b43ec5a31fa"
  else
    odie "Only amd64 is supported as of now"
  end

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
