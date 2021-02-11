class KubeoneBin < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io/"

  url "https://github.com/kubermatic/kubeone/releases/download/v1.2.0-beta.0/kubeone_1.2.0-beta.0_linux_amd64.zip"
  sha256 "f072b33c11a4b93ca4f9e2067985e19f8f09db2d871af8fb4e35b63cdf11d5ae"
  license "Apache-2.0"

  bottle :unneeded

  def install
    bin.install "kubeone"

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
