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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.4.2"
    sha256 cellar: :any_skip_relocation, catalina:     "784aaf0b34621b941383cc3db24511b9a80fdbb232efc8e191c8800a34d30707"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "df682c7ec0b114678487c8fcd739b3ba515ccf1ddb2b2030e95bba56d3e6f2f5"
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
