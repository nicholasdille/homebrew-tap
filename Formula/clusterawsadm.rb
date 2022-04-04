class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.4.0",
    revision: "b038843096636cbfd6992b52a2aef145d0dd12f1"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "68a41f3a88a68c5345aad3cfa40e31d17ff3cef9d4bd7dd4a5707f4eaf71965b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "363c90376eb5d5b5d665c37c367bfa7fa53fc37b8621ea6db094999ebe1815bc"
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
