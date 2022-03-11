class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.3",
    revision: "f2abdbd2910e11ecc32d39b09cf41c923140b61e"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.3/loft-linux-amd64"
      sha256 "7b4b3c8889958bf8bdb34b2b9016b28a5694f09a369b8fbf803c884971d0ecba"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.3/loft-darwin-amd64"
      sha256 "c88656bc4b650a54627e28f2a87e5fa2f5d3579b6c3af6809e78fcb1e3f2f245"
    end
  end

  def install
    resource("binary").stage do |binary|
      bin.install binary.url.split("/")[-1] => "loft"
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
