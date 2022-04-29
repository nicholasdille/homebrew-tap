class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.4.1",
    revision: "c149903b9ac6441bed8991423cb5a43141d262fc"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "2a81b325b7b5d9ee4b2a4d60448c0424a2ba803edbc925d1d0939a353b3558bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9816bb3c5b5b2f17a652c200267e6c6ee23991534afce53a800ef0129c38ff75"
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
