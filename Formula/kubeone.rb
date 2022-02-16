class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.4.0",
    revision: "24a432834629b860257e4f3975ec223bc85a0c2f"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "5cd04db816eda7d3cfe6f224d51aeca8c92cf23dee0ab20bee9d5c72acea1c1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b1b142e808ce5c42024f03d3c3a69342c1835807fff811e3213458ea6c597019"
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
