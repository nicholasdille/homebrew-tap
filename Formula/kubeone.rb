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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.3.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "5ac80224563b623459dfab383efe21393fb02f71ccd80a850ab7d35e6024bdde"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45e87e7419612e2351522eeac09e29624b27c9baab97ce041305df169101809a"
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
