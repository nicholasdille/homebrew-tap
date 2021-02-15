class RootlesskitBin < Formula
  desc "Linux-native 'fake root' for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit/releases/download/v0.13.1/rootlesskit-x86_64.tar.gz"
  version "0.13.1"
  sha256 "f951d9681860926277396a288898963da1b874ce9a89ec9dea338d0eaf001c1f"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/rootlesskit"

  def install
    bin.install "rootlesskit"
    bin.install "rootlessctl"
    bin.install "rootlesskit-docker-proxy"
  end

  test do
    system "#{bin}/rootlesskit", "--version"
  end
end
