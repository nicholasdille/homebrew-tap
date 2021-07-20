class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v0.4.0",
    revision: "7f879be68d15737e335b6cb39d380d1d163e06e6"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "84b4c5b9758795e85db23bfd3329b9825f8defc6fc6425879ff9ea9e559f339e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "961c595c1295a870e11d49b6ac3bc99f55bb70fbdbd31686eb4ec111daf5134e"
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
