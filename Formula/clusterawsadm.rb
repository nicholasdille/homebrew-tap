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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "6e91dfa8da20cef410c7a04e26f0e481dd89ae73959a14e9e2e9ecd663f28b7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29a9e330d9df0bffc5ccbc8879b59fc95d980dc2b210d8c4d6ffeae9601f4938"
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
