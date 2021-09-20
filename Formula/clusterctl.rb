class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.4.3",
    revision: "a3e4b37c40ef8bc8ca1748fecb9b98c88b868e1f"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.4.3"
    sha256 cellar: :any_skip_relocation, catalina:     "fa51d72d2d559133bfa6317e203dfd57d0fc0b813ce7492044c99c2c4252d07f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fc2b9c38ad82f490f534e97cfa1c923836cc602c8c725b1b62d74898e1b68e06"
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
