class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.4.2",
    revision: "e1ef6466e56fb543b011239faa42e32cd712101c"
  license "Apache-2.0"
  head "https://github.com/kubermatic/kubeone.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.4.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "0a0b75eee542c366982661505e3143583667ad3b2473e3b0a1241b1baa768c36"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4f71eafb36904f4377bcc2b3539cdaff2e8151f3f3af9dbc29880d738813b25e"
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
