class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.8",
    revision: "340b6b9a04e61fc5ff4d4545bc25700cf8bb8b62"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.6.8"
    sha256 cellar: :any_skip_relocation, catalina:     "334525408650d9df7b557f73d3939d0047c0af169e6de08def18eeda7d851645"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d76d1579513e1442e5bc5b9bd23f7e9c019cb5e2d77b608363cf5acbe2a1efee"
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
