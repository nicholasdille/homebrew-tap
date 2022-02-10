class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.0",
    revision: "a293cdc9ca9b7f88fc5fbcebf6209a1c70a39544"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.0/loft-linux-amd64"
      sha256 "6d413587981f11c32c9fe55925249362f5dbeaab16cebb8234deb3b03363fe39"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.0/loft-darwin-amd64"
      sha256 "b8e9a34765fd7606ab5d496995615ee57351fc34b90740f3a8428bf80cc18434"
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
