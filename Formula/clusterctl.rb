class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.0.1",
    revision: "2887be851a4384bb000d2a498099f96fe0920cd1"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "f21365a7ef80a067ac2f47b9d7990875b3a4c148cae4c45789185e5cade972f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a913674f06fbfb53ab63bbab19e8e32bfbbf87c7fa549afe821fcd3b0f2d8749"
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
