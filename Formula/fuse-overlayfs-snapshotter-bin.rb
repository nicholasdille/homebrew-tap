class FuseOverlayfsSnapshotterBin < Formula
  desc "Plugin for rootless containerd"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v1.0.3/containerd-fuse-overlayfs-1.0.3-linux-amd64.tar.gz"
  version "1.0.3"
  sha256 "26c7af08d292f21e7067c0424479945bb9ff6315b49851511b2917179c5ae59a"
  license "GPL-3.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :x86_64
  depends_on :linux
  depends_on "nicholasdille/tap/containerd"

  def install
    bin.install "containerd-fuse-overlayfs-grpc"
  end

  test do
    system "whereis", "containerd-fuse-overlayfs-grpc"
  end
end
