class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.0.2",
    revision: "e6554e03ca1984cbf8bb0a15c007926d8d9ee345"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.2/loft-linux-amd64"
      sha256 "dea9422e8ae066b42ee779d02bc26c4d445ad4e87390fe30f5adb00c6db90b79"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.2/loft-darwin-amd64"
      sha256 "948cd70c31dfcea0a6ad3629136bc29a0a0f8d9363bbe68fc81d12d4290611e4"
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
