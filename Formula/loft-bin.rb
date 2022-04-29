class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.8",
    revision: "1c868a8c30eca6a24f32f922e4c19de455add01c"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.8/loft-linux-amd64"
      sha256 "c173b8715a4c7bcd10d5bceacdc592a10019e8ca77124500237dfe5498316179"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.8/loft-darwin-amd64"
      sha256 "a528b8d1c08792f9fa7c5ba940bac1fa35ae989f453cd8afe8416114099a1369"
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
