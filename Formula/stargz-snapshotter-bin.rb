class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.7.0/stargz-snapshotter-v0.7.0-linux-amd64.tar.gz"
  version "0.7.0"
  sha256 "188daaba9bfc5c1aeca6b8a4159b73839c241a75247e6cc5d56e604c3f27df38"
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
