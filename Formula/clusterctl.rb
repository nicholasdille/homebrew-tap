class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.3.16",
    revision: "6d7649fc5f407ac48b6d8e3929c97822527c0454"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.3.16"
    sha256 cellar: :any_skip_relocation, catalina:     "cd15f019d88736b8291ebc81e95ee908cc9a2bdb4e7be251f6dc7896e1163f10"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "646f955269fbfacfdb6eca571d2094845dc78c376f213eb21803fe6b08e515e1"
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
