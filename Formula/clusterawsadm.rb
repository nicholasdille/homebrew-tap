class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.0.0",
    revision: "0fb108ac19f544a33a7c31a5278f212fbb88ccc5"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.7.0"
    sha256 cellar: :any_skip_relocation, catalina:     "b6de5bd81bb15d27670b10b55df9858cd5d9600d552303539f525d337a33400d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3afecb344e5f96ebb1d521b1d4a6f17e9e1a6c501fb8c8bfe6589ccaff957a87"
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
