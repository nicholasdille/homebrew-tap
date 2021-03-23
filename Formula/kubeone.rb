class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.2.1",
    revision: "51a3729d1f5868e740861bec9fb6b8083bebf6ec"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.2.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48750ee6db64811d7807722a68775a824e581cbcc12a0146a2d8ab8f8d720e96"
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
