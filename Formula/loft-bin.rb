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
      sha256 "02974a0305b518e2fbfbb48373701a71219336baa973bc87bacc797037736be1"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.0.2/loft-darwin-amd64"
      sha256 "6d57f42d069de4b546cd4c778fca525f37bf8c7af991255f773ae126fdb509b2"
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
