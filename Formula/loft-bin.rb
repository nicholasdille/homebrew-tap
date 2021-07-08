class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v1.13.0",
    revision: "82f81d803f7c5cc46a130e828c50d4afa32680dd"
  license "Apache-2.0"
  head "https://github.com/loft-sh/loft.git"

  bottle :unneeded

  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v1.13.0/loft-linux-amd64"
      sha256 "7b54ab4ab46815690ce53177f5f94ba55333c8b110d0ea55e2705b13c9b01b3a"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v1.13.0/loft-darwin-amd64"
      sha256 "35e22b65bdcf3f72b2111db989da6da45ccafaaf04ff83bf6f0f863e75fe6f42"
    end
  end

  def install
    resource("binary").stage do
      os = "linux"  if OS.linux?
      os = "darwin" if OS.mac?
      arch = "amd64"
      bin.install "loft-#{os}-#{arch}" => "loft"
    end

    # bash completion
    # output = Utils.safe_popen_read(bin/"loft", "completion", "bash")
    # (bash_completion/"loft").write output

    # fish completion
    # output = Utils.safe_popen_read(bin/"loft", "completion", "fish")
    # (fish_completion/"loft.fish").write output

    # zsh completion
    # output = Utils.safe_popen_read(bin/"loft", "completion", "zsh")
    # (zsh_completion/"_loft").write output
  end

  test do
    system bin/"loft", "--version"
  end
end
