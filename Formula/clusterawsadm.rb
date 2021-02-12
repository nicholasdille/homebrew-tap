class Clusterawsadm < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "http://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git",
    tag:      "v0.6.4",
    revision: "634f30eb5a3ab42ec21e358cfb86da740784aed7"
  license "Apache-2.0"
  head "https://github.com/kubernetes-sigs/cluster-api-provider-aws.git"

  depends_on "go" => :build

  def install
    system "make", "clusterawsadm"
    bin.install "bin/clusterawsadm"
  end

  test do
    system "#{bin}/clusterawsadm", "version"
  end
end
