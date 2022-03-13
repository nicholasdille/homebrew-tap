class LoftBin < Formula
  desc "Namespace & Virtual Cluster Manager for Kubernetes"
  homepage "https://loft.sh/"

  url "https://github.com/loft-sh/loft.git",
    tag:      "v2.1.5",
    revision: "7dab702cae4b15f85fe4c6e8d68b742e2a6c4886"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "git-lfs" => :build
  depends_on arch: :x86_64

  resource "binary" do
    on_linux do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.5/loft-linux-amd64"
      sha256 "2a41a67e9876aa5e8c4aabec27443c10b3f92e9752f0ad33edd841b7d3808d6f"
    end
    on_macos do
      url "https://github.com/loft-sh/loft/releases/download/v2.1.5/loft-darwin-amd64"
      sha256 "7152f210ed1ef699c2c361c2abc26bd2f3c801c38c7bcc5b75844db6dda48d6b"
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
