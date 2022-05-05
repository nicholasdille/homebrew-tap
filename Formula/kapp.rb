class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.47.0",
    revision: "148d1bd3b1133bd8f303d7a81062dd83c45830c3"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.46.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "f253ebe02cd25ff808b5cf7e26ed395c0a188ed2b87e9635fe348184d6dcf7e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a1970cb51cd83ac7e05f0d802a44e3a5708fbf19fec420b6ac1fa5549dce0df4"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"kapp",
      "./cmd/kapp"

    # bash completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "bash")
    (bash_completion/"kapp").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "fish")
    (fish_completion/"kapp.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kapp", "completion", "zsh")
    (zsh_completion/"_kapp").write output
  end

  test do
    system bin/"kapp", "--version"
  end
end
