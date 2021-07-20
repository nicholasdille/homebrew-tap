class FuseOverlayfsBin < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containers/fuse-overlayfs/releases/download/v1.5.0/fuse-overlayfs-x86_64"
  version "1.5.0"
  sha256 "53e54b2febf39ba6e67018294a7162bd6b4d18cb544ed7aff54c29ffb2791606"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle :unneeded

  depends_on arch: :x86_64
  depends_on :linux

  def install
    bin.install "fuse-overlayfs-x86_64" => "fuse-overlayfs"
  end

  test do
    system bin/"fuse-overlayfs", "--version"
  end
end
