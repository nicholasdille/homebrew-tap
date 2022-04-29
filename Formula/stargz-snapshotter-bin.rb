class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.11.4/stargz-snapshotter-v0.11.4-linux-amd64.tar.gz"
  version "0.11.4"
  sha256 "56933aa04a64d3bf6991f9b1be127ac9896fe597d2fba194c67c2dd4368bbae3"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.11.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6c3c010fd2f83ab749a1a9a65572d77a76849ff34a820b136c8cbf5a565cc8d6"
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
