class ClusterawsadmBin < Formula
  desc "Kubernetes Cluster API Provider AWS provides consistent deployment and day 2"
  homepage "https://cluster-api-aws.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/v0.6.4/clusterawsadm-linux-amd64"
  version "0.6.4"
  sha256 "6923dfe1af70ebbe61c3fbda91528ebabdec324bccdd22623b8484098c49910c"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/clusterawsadm"

  def install
    bin.install "clusterawsadm-linux-amd64" => "clusterawsadm"
  end

  test do
    system "#{bin}/clusterawsadm", "version"
  end
end
