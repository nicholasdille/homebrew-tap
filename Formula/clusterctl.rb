class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.1.1",
    revision: "810c2a67e71ed3344a29ae79862407d6b0631a79"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "6666790c1c8e61cbf526d1c58a2da149f5452bfdc589d35fbedf8d01f2aff0ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2214946e25bb4227b867cdb400aebe259008445fffddf125333f2f72f605e79"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "clusterctl"

    bin.install "bin/clusterctl"
  end

  test do
    system bin/"clusterctl", "version"
  end
end
