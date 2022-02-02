class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.1.0",
    revision: "e2aafb60cdf72ea086b56727dfac76f13ac6f9fe"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.0.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "18452020d57fbf64692ad5bf621e1f7f245bb1157658862c9b63da27bedc53ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9954987db6d50bf73fa8919fec41311dbcb6bbd3c958c2080a3f6548bccd8603"
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
