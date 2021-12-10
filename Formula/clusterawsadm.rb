class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.2.0",
    revision: "c356b7e776a70f5ce70a039641ef5b2e992d2d43"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.1.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "0efcaee326467d180beb064402caf2eeff6a4687b4964443bc915446c9074411"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d38d0b55a97b6ab16801251bb4753fbcd10a341c8449f4e29fcaa79c8b827545"
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
