class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.2.2",
    revision: "9d3c776903ec759a7cfce5506d9d644a297cfc81"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.2.1/loft-linux-amd64"
      sha256 "e0e9f03117f732b0688226d6e78f6e9c856769488255d96d8cc87f25c860710f"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.2.1/loft-darwin-amd64"
      sha256 "d9b0866656f8c9c2c94faad7920e845de315159f3786d5c031f4f04ec6792df0"
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
