class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v1.15.0",
    revision: "f5d81c98b53c97d30f1f40239fd1bb2daf23aa25"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v1.15.0/loft-linux-amd64"
      sha256 "93de5fd32ed0acaf477717055fd1327c681a550355984892216354016ee1cf02"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v1.15.0/loft-darwin-amd64"
      sha256 "a64cd96f62ac26eb363b257bf4a2a83e0a23c918f72ea7e3e869f11b9733056a"
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
