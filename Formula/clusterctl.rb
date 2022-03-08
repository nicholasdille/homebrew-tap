class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.1.3",
    revision: "31146bd17a220ef6214c4c7a21f1aa57380b6b1f"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "91271cf329cbdc55bbc29c5b96ff7daf166bd72af1f9df656efd788a3f47e2df"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec3c32484582a7b9fd2fe58fec297913a1ddadbb399511f5a776658a0b738e4f"
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
