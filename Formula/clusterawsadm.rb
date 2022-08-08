class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.5.0",
    revision: "5a3d0cf2f0d0079da5017969db7a51f385c6e4d8"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "58e2cb7ab9c3d58cf325c06f7c26933748fb9149b5a30b4f88f12d3add804da6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "36cf358d2e9832e0b5ab3dfa3f2e75d1db142048f90ac616bace32f248c1ff72"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "clusterawsadm"
    bin.install "bin/clusterawsadm"
  end

  test do
    system bin/"clusterawsadm", "version"
  end
end
