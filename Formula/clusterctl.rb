class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.4.0",
    revision: "7f879be68d15737e335b6cb39d380d1d163e06e6"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.3.19"
    sha256 cellar: :any_skip_relocation, catalina:     "bbf0e262fa72172a283683e9909448a12f10b9fdca750df711484f418ba71dcb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f397ab18b689bf1599dfa38adcd34517d8dbdc158aa9071ad67848b017ae3801"
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
