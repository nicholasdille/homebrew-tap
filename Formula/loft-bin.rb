class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.6",
    revision: "c8320dcd78b8945dbe255f5eb71b6d18e7ad9dad"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.6/loft-linux-amd64"
      sha256 "abb4562877f5dc7ec636e59514963e013091d41a7d9218b6f364ee940d475105"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.6/loft-darwin-amd64"
      sha256 "1a083caebdffb0299aa5fa2a2399dd30af3d99b786a0b2a5acd1eb3a0cebd662"
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
