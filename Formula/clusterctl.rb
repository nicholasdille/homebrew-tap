class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.4.2",
    revision: "dd8048ce988bd7d7ab6dce760c2ce12e06c2482b"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.4.1"
    sha256 cellar: :any_skip_relocation, catalina:     "7ba8214a6d69216a3f65ab3440b1a66a6ce6299c2ededb24dd4c9044b3f32baf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1203ec434572fce5aaa1edf54cd66a1b82c4d85ad0760f152d0d5ceffeefd7db"
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
