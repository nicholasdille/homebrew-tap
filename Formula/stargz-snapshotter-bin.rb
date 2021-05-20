class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.6.1/stargz-snapshotter-v0.6.1-linux-amd64.tar.gz"
  version "0.6.1"
  sha256 "33199510a712b8f52458f6ce07342db3f92e59d2137d46d90e59d7e865e7460b"
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
