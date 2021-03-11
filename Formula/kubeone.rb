class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.2.0-beta.0",
    revision: "a039926b9838fcbd79424ea0d48c0bb299ee7278"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.2.0-beta.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d72c0bf0b4d552dc0f93fa17ffa7fc25cc263c01aee38ca3a80f7d7264b16c56"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "dist/kubeone"
    bin.install "dist/kubeone"

    # manpages
    (man/"man1").mkpath
    system bin/"kubeone", "document", "man", "-o", man/"man1"

    # bash completion
    output = Utils.safe_popen_read(bin/"kubeone", "completion", "bash")
    (bash_completion/"kubeone").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kubeone", "completion", "zsh")
    (zsh_completion/"kubeone").write output
  end

  test do
    system bin/"kubeone", "version"
  end
end
