class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.3.3",
    revision: "6ef9df813469582343b1feef66849c3bf81aa956"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.3.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "8e4e5d816703f40dfe2ab9c913640bc759bbbc96b0041aa54b5088a7d788cb91"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3c2a56e9f37e66ac244dc943df424b85ef4d22a6a9b79d7272760f427ff3b62f"
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
    (zsh_completion/"_kubeone").write output
  end

  test do
    system bin/"kubeone", "version"
  end
end
