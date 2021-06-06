class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.6",
    revision: "4ca623be01b48cc6a28f83d600b582aa7417498e"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.6.5"
    sha256 cellar: :any_skip_relocation, catalina:     "355636d79b9d892f9b262bd016852e27d363921eed61ba5eb977719676d8c48c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d1f3006fc3d48155903d9d16a6c8e91b89b7329293fcb8eecf3a0e2629ce58a8"
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
