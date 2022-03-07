class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.11.2/stargz-snapshotter-v0.11.2-linux-amd64.tar.gz"
  version "0.11.2"
  sha256 "91fe8955d6e04cef623ee043ca659400308b4a5ac184665ea8b7e5d661a24a74"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.11.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "04fa02790a509bded869372e96b992ccae13b1fad03959987c4cdb4f69d2b0c0"
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
