class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.4.4",
    revision: "d50c55d5df741b0c61834bcc1802451d80e6c200"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.4.4"
    sha256 cellar: :any_skip_relocation, catalina:     "ae00e4078609d54f13d24e8de831535b04d2f654ff08b6162324a7714ac88b4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "81735e3303c8a2b5952299a5829610097683fb3c5cd950f8bbcea57a1f185c68"
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
