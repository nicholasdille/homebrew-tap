class FuseOverlayfsSnapshotterBin < Formula
  desc "Plugin for rootless containerd"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v1.0.2/containerd-fuse-overlayfs-1.0.2-linux-amd64.tar.gz"
  version "1.0.2"
  sha256 "1f1e69f71b5ea568e93e40059af1b02a377ac0966d2acd27e4cce388a27af218"
  license "GPL-3.0-only"

  bottle :unneeded

  depends_on arch: :x86_64
  depends_on :linux
  depends_on "nicholasdille/tap/containerd"

  def install
    bin.install "containerd-fuse-overlayfs-grpc"
  end

  test do
    system bin/"containerd-fuse-overlayfs-grpc", "--version"
  end
end
