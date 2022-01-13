class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.0.4",
    revision: "fe81d5af70f8bf707642f17bd9badcd02873dfba"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.4/loft-linux-amd64"
      sha256 "4debab5a09d05a09bdf15871fc70039b1c7a46d1352bdd7645a729a34c31b757"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.4/loft-darwin-amd64"
      sha256 "2967b07637f3695139da5dbea014473ef2de55ac6bbd5ff3dab28c5f8500afcc"
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
