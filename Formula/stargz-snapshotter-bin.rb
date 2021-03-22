class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.5.0/stargz-snapshotter-v0.5.0-linux-amd64.tar.gz"
  version "0.5.0"
  sha256 "a800f1ef707443260df6ea2b0627edb404ecad67bbbefea81b997c4499555b02"
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
