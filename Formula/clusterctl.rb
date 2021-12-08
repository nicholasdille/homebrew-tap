class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.0.2",
    revision: "89db44e9a462028267ed49295359fe9db2a6a10a"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.0.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "0a68b7f7fb2d990a158c109ee98d06d090ba35f245fcea25419255b31e890c37"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c55d781f258d79cf671acaee426daa27a7eeb9f62884995b522d8d3823d17573"
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
