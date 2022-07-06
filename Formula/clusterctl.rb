class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.1.5",
    revision: "d488bdb875d302eba85221fa35c9f13c00df4ae7"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "f37e5d069e120f4200fa634356ed1c72ccc1223564bbc8c3028c34730e6655a4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ea5267ad3a97fd23b6a1edd180c7476e4c559e1f354ba49323e8fa0687822845"
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
