class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.10.0/stargz-snapshotter-v0.10.0-linux-amd64.tar.gz"
  version "0.10.0"
  sha256 "e5bcfec5ab68f819ca679a17a40ed6cde2807d316368ef17a916a7f52fd02646"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.10.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4cb1408fbfd98b2076d79c8485506076c1d920bf8c86c10779083ab444f35fdf"
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
