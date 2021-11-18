class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v1.1.0",
    revision: "0b2e34680d117b1d8146965f3123c04709d37951"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-1.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "1da6feb297e51752ed2643ccd2b59298f415b83d14181845b11af6f434c2b144"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "26f14a70d10cec9276e1e1a5d54b4f232c5d2ff175cdf2e46444cdf64d8a7d8e"
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
