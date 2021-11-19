class FuseOverlayfsSnapshotterBin < Formula
  desc "Plugin for rootless containerd"
  homepage "https://github.com/containers/fuse-overlayfs"

  url "https://github.com/containerd/fuse-overlayfs-snapshotter/releases/download/v1.0.4/containerd-fuse-overlayfs-1.0.4-linux-amd64.tar.gz"
  version "1.0.4"
  sha256 "228417cc97fea4df26ed85182443ee4d5799f65ada0b3ce663bf7e6bc8920f6b"
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
