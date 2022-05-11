class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.4.3",
    revision: "717787f2287964e5793d80ec8ca2c2169936b0ac"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "dist/kubeone"
    bin.install "dist/kubeone"

    # manpages
    (man/"man1").mkpath
    system bin/"kubeone", "document", "man", "-o", man/"man1"
  end

  def post_install
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
