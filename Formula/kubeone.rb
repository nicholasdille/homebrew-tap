class Kubeone < Formula
  desc "CLI for KubeOne"
  homepage "https://kubeone.io"

  url "https://github.com/kubermatic/kubeone.git",
    tag:      "v1.2.3",
    revision: "7e290081fe4bfe38f93ecf6d8fa68e53be469711"
  license "Apache-2.0"
  revision 1
  head "https://github.com/kubermatic/kubeone.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubeone-1.2.3"
    sha256 cellar: :any_skip_relocation, catalina:     "11022bfdd7b8016507b3ffd1e62742a69d99353bb2a6072dbcc9ba3d9c421e35"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5cfd96d4d6b5c618e253d2a92641b9dd8fa26a66f16a31e66debaa5b6c6188b1"
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
