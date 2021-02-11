class ClusterctlBin < Formula
  desc "Home for the Cluster Management API work, a subproject of sig-cluster-lifecycle"
  homepage "https://cluster-api.sigs.k8s.io/"
  url "https://github.com/kubernetes-sigs/cluster-api/releases/download/v0.3.14/clusterctl-linux-amd64"
  version "0.3.14"
  sha256 "5cb90936a12e7684763a6d82f8e449ac5cdc72e5a91322297fd20ab5bed37682"
  license "Apache-2.0"

  bottle :unneeded

  conflicts_with "nicholasdille/tap/clusterctl"

  def install
    bin.install "clusterctl-linux-amd64" => "clusterctl"

    # bash completion
    output = Utils.safe_popen_read("#{bin}/clusterctl", "completion", "bash")
    (bash_completion/"clusterctl").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/clusterctl", "completion", "zsh")
    (zsh_completion/"clusterctl").write output
  end

  test do
    system "#{bin}/clusterctl", "version"
  end
end
