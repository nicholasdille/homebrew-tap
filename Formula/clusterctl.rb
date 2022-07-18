class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.2.0",
    revision: "aebeed871c780cfc71bc292dd59eed381da0771f"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.2.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "163ae1e61e2f50e52eecb13c952aab94a55dd63d35bb6f1337b9aa941b6bc188"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b19c11a6bcf2ca94e1d08dd600817da06d9d50627c511b5979f551bba61c83fe"
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
