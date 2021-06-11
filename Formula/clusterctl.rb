class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.3.19",
    revision: "665d56652a787180dc36ecbfdf183b1e436fba75"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.3.17"
    sha256 cellar: :any_skip_relocation, catalina:     "836f00dc315db7e8a7f06c190a87e9625f289481d053913315c93049bf6dbaf4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "de7f21827ff77549cf1e9350e2d53ecb218f7f77143da4dfa42ab496c3fc25e9"
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
