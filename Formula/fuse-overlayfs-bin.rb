class FuseOverlayfsBin < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containers/fuse-overlayfs/releases/download/v1.6/fuse-overlayfs-x86_64"
  version "1.6"
  sha256 "ab9760bee3fcc383f21d560b1b90430e118ab8b615a40c9938f88485eb4f8d04"
  license "GPL-3.0-only"
  revision 1

  livecheck do
    url :stable
    strategy :git
  end

  depends_on arch: :x86_64
  depends_on :linux

  def install
    bin.install "fuse-overlayfs-x86_64" => "fuse-overlayfs"
  end

  test do
    system bin/"fuse-overlayfs", "--version"
  end
end
