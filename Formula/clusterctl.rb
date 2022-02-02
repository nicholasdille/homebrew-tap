class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.0.3",
    revision: "b3bd6cc9c6525f166441ff2635faa48e60884a51"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.0.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "bbcdfea9e8535ecdb80d32ec47815de0ca3786957fafd713095a53ac9ff16a8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "33e732fe039c64df041a496539d4e8f48cc28220d5dae301881484743cd5c22d"
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
