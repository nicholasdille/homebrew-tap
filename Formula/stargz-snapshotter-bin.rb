class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.11.1/stargz-snapshotter-v0.11.1-linux-amd64.tar.gz"
  version "0.11.1"
  sha256 "f958a77b9cc639620af78208b34213fbd17fe28699708a7d3a9c7862025a7a4c"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.11.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c292c3451483f7374f359122c0be893abca212088616dbd7ab6a61d350b56417"
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
