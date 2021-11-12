class Clusterctl < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"

  url "https://github.com/kubernetes-sigs/cluster-api.git",
    tag:      "v1.0.1",
    revision: "2887be851a4384bb000d2a498099f96fe0920cd1"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterctl-1.0.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "eea1a5af97a584edbac2a9d9c412519fc243048e7b545d9dcf0bc2a2ec2742f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f71b8f8e89fb800eeb80f5a8add7b5d2333713e88f183d3a24746f948d06a1d"
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
