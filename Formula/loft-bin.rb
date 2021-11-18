class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.0.0",
    revision: "80c9d18ff957e023f2f70824c4d903d22b550855"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.0/loft-linux-amd64"
      sha256 "e8e4f38e746b410762b8125e65ae7bbcd6a48d7f28cd8b0522620b38b70c51fe"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.0/loft-darwin-amd64"
      sha256 "15e508fbaefb43d3aeb32952c0e0a7260970505f2c221b9aa945b2b74fa03a17"
    end
  end

  def install
    resource("binary").stage do
      bin.install resource.url.split("/")[-1] => "loft"
    end

    # bash completion
    output = Utils.safe_popen_read(bin/"loft", "completion", "bash")
    (bash_completion/"loft").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"loft", "completion", "fish")
    (fish_completion/"loft.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"loft", "completion", "zsh")
    (zsh_completion/"_loft").write output
  end

  test do
    system bin/"loft", "--version"
  end
end
