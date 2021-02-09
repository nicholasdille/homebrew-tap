class Kubeone < Formula
  desc "KubeOne CLI"
  homepage "https://kubeone.io/"
  url "https://github.com/kubermatic/kubeone.git",
    tag: "v1.2.0-beta.0"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git"

  depends_on "go" => :build

  conflicts_with "nicholasdille/tap/kubeone-bin", because: "both install `kubeone` binary"

  def install
    system "make", "dist/kubeone"
    bin.install "dist/kubeone"

    # manpages
    (man/"man1").mkpath
    system "#{bin}/kubeone", "document", "man", "-o", man/"man1"

    # bash completion
    output = Utils.safe_popen_read("#{bin}/kubeone", "completion", "bash")
    (bash_completion/"kubeone").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/kubeone", "completion", "zsh")
    (zsh_completion/"kubeone").write output
  end

  test do
    system "#{bin}/kubeone", "version"
  end
end
