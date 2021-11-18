class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.10.1/stargz-snapshotter-v0.10.1-linux-amd64.tar.gz"
  version "0.10.1"
  sha256 "8cb1f626a18bd693cbd115ba343c5a7bcd9d8f81e0393efc742d357d3c2c9209"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.10.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6b6ac26ff5bcf900dee20988025cdb2fa2b63f044aa44fbc82df00c1febba5cc"
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
