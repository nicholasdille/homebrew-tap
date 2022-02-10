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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "4418de8aee51287d7c8e534a35f4fbb696c454ab4d98cc7697c1cc68aaa99012"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7e3fa2f8fabf06f8ba7b970f82cde062304c4750eba3ed903a44909c4384c23b"
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
