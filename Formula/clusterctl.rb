class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.3.14",
    revision: "5a09f69fa8c4892eb45a61d8d701140eeeaa5ba8"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  depends_on "go" => :build

  def install
    system "make", "clusterctl"

    bin.install "bin/clusterctl"
  end

  test do
    system "#{bin}/clusterctl", "version"
  end
end
