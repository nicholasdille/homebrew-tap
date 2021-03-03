class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.4",
    revision: "634f30eb5a3ab42ec21e358cfb86da740784aed7"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.6.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aca68e8585781f17b8e10a074b991abd6818d17e2ad03c58ca10c3781b4c7d9c"
  end

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "clusterawsadm"
    bin.install "bin/clusterawsadm"
  end

  test do
    system "#{bin}/clusterawsadm", "version"
  end
end
