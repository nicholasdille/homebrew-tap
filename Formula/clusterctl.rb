class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.3.15",
    revision: "b900c6f89f3d433c32db1aa269f77f004a83cc4f"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.3.14"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "46a9ff62ce3216aeffab44270ddad7f5304c131b315665c3c92390f47ee6881b"
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
