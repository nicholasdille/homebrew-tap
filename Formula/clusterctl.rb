class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.2.1",
    revision: "8b4214d72762394144b83dd6d14986ff7e274095"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.2.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "ba8270fb20e47764b41d682884f46d53fd4da02dfd47260322af4a85f4c3e431"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8f713126ed7f5c5bd5cb66c19625a37ca5dd0852778b64470f3545c0d16152df"
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
