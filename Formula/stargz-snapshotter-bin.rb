class StargzSnapshotterBin < Formula
  desc "Fast docker image distribution plugin for containerd, based on CRFS/stargz"
  homepage "https://github.com/containerd/containerd/issues/3731"

  url "https://github.com/containerd/stargz-snapshotter/releases/download/v0.12.0/stargz-snapshotter-v0.12.0-linux-amd64.tar.gz"
  version "0.12.0"
  sha256 "eda248bbe26923d12557a21dd5d22309ee2fa769a07070723ee65a918dd87453"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/stargz-snapshotter-bin-0.12.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "43a1e125c30c502c790dfe72bf48c9191ab969841d060ea96d770c8ad147b0b3"
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
