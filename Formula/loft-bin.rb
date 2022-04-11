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
      sha256 "2cbc557f2ffc44ef28cdf14ce1de3eaf1d7e9e22568c944087713f4a976df59d"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.7/loft-darwin-amd64"
      sha256 "de86b7586c0c92f0a9dc64854fc0cc7111b0fdaa996939f341d7e30d967bbe3d"
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
