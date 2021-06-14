class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.2.3",
    revision: "7e290081fe4bfe38f93ecf6d8fa68e53be469711"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.2.2"
    sha256 cellar: :any_skip_relocation, catalina:     "7550efdc06b323e15ad73c7b30c39ff3c1bee240e872ed222c6e118aa2d1a697"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9dd659fac0a97d580a6a3ae3452821272a8cdb6617f4e67c64334bd6ff2a6c6"
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
