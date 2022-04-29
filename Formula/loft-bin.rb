class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.7",
    revision: "ae3f51ae0ac65d01c83660704f37ccba78612d08"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.7/loft-linux-amd64"
      sha256 "6b7575bc638f4394a23792d37c568f3f1fdd7d829f9d0479b03e509e96da177f"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.7/loft-darwin-amd64"
      sha256 "9ce62087ebce7c380c0353fb051a26003e0fe87c30d062b0b0b891c603d138d9"
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
