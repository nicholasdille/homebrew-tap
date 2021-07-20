class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.7",
    revision: "50f8b3fa1d730d44b133a05ed2fdf579bb399f2e"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.6.7"
    sha256 cellar: :any_skip_relocation, catalina:     "1e8b5ce7235c751607bf6668d95d12791a2fcd992715c1973d36e35866aec4d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d3755351a10ca48e05fde27902b72fdf44f18457e760e3f2628d523726e2ff8f"
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
