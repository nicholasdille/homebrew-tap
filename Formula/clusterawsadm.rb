class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.3.0",
    revision: "5bf5c5c264e56a8555f25fb73299b7923229cd84"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.2.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "3277fe85657d2f5eb4440db806d5c87f22b1270eaf21dd554b94b9560f0bceda"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07090ced40093cb8ac086da1994ecd78cef710f3760408b77cee64ccde21a6b6"
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
