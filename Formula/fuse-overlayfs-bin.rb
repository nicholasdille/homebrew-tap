class FuseOverlayfsBin < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containers/fuse-overlayfs/releases/download/v1.4.0/fuse-overlayfs-x86_64"
  version "1.4.0"
  sha256 "692cb1d5917159c09ee2fe005ad136b2ca75469fc52cd07d67361aca88a5a8f3"
  license "GPL-3.0-only"

  bottle :unneeded

  def install
    bin.install "fuse-overlayfs-x86_64" => "fuse-overlayfs"
  end

  test do
    system bin/"fuse-overlayfs", "--version"
  end
end
