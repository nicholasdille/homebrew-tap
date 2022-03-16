class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.11.3/stargz-snapshotter-v0.11.3-linux-amd64.tar.gz"
  version "0.11.3"
  sha256 "3500a7bd7b44200a80588afd2590feba1655092722c7739fa10242d09c2976f4"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.11.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "baa0539187a78e5394a205eb1f6d63def9757a4bb6bbdb3a043e2809b06fb0e9"
  end

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
