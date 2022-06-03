class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.1.4",
    revision: "1c3a1526f101d4b07d2eec757fe75e8701cf6212"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "15c9a7c0c758e9301998ab78704d1dee346b02ef6c8efa2d081edf72030dbf1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5466ba3419457dda2bf7700a00e39183c2f8949408bdfd6b0425e6eebe31b55e"
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
