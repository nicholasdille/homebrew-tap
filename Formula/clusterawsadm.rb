class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.7",
    revision: "50f8b3fa1d730d44b133a05ed2fdf579bb399f2e"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/clusterawsadm-0.6.6"
    sha256 cellar: :any_skip_relocation, catalina:     "015048d98317586d9b82636bcaae429f615739dd0db6c83c3af932df26eede2a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "80ae2781861f3b3a4a4c0d9b375f44fb3753f4ea11ec1b4c4aca391bf2381d7e"
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
