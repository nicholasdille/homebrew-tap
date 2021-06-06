class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.6.4/stargz-snapshotter-v0.6.4-linux-amd64.tar.gz"
  version "0.6.4"
  sha256 "60f2a6bef439c6d76809e2f94fb91d025e1e20152715618fda065c53dd8bc651"
  license "Apache-2.0"

  bottle :unneeded

  depends_on arch: :x86_64
  depends_on :linux
  depends_on "nicholasdille/tap/containerd"

  def install
    bin.install "containerd-stargz-grpc"
    bin.install "ctr-remote"
  end

  test do
    system bin/"containerd-stargz-grpc", "--help"
  end
end
