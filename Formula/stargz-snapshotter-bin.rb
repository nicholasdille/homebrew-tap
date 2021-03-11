class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.4.1/stargz-snapshotter-v0.4.1-linux-amd64.tar.gz"
  version "0.4.1"
  sha256 "954553e1b4a8731998f60aa85bdd6a31dee958e5ec4a8fbf38e965dafba8b506"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "nicholasdille/tap/containerd"

  def install
    bin.install "containerd-stargz-grpc"
    bin.install "ctr-remote"
  end

  test do
    system bin/"containerd-stargz-grpc", "--help"
  end
end
