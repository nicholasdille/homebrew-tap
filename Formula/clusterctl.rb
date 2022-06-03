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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.1.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "7ce9e3281e81dfc9e0e40b4c0c57c8c89311e770da1087580bde4d00160c9fbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "169cfa7b58ff18772fdd5d6604b2bbd7e932262a39e12b701f97c04a387f676d"
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
