class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v1.12.2",
    revision: "25b3344a4333dd9458ba09240ba6aba29eb30480"
  license "Apache-2.0"
  head "https://github.com/loft-sh/loft.git"

  bottle :unneeded

  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v1.12.2/loft-linux-amd64"
      sha256 "505533f523076a687668e495ffd1129b06f5a08bade3814edc1c7282ed087be5"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v1.12.2/loft-darwin-amd64"
      sha256 "e6814dba937d22c2df8c509e85f769233de6ae4011fe7ed6494de9a7fbe424e2"
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
