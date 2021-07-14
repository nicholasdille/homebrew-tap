class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v1.13.1",
    revision: "ac133522bb806e7c8ceea91417bcf0372103ddfc"
  license "Apache-2.0"
  head "https://github.com/loft-sh/loft.git"

  bottle :unneeded

  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v1.13.1/loft-linux-amd64"
      sha256 "b90436fab0ac2d006874a91311bf5b4341f3d666c3265bc2b7344894e3730ff3"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v1.13.1/loft-darwin-amd64"
      sha256 "c24297cccfe0bdf222165ea476b919c8f80c95e9fcace72c55401e9e11fd2554"
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
