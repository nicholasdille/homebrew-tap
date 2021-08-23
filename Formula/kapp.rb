class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.38.0",
    revision: "c35f479f0bf32a7467179d88bbb5317a618f0738"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.38.0"
    sha256 cellar: :any_skip_relocation, catalina:     "1571d45b95794e458bbc5ba7b28819c78f5426ca0bd610b7c1bde34ad4dadb30"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "74270e636f3ca09a27cb89227a3877a2cbf0fbbb54b1e74b04c36d5017623c58"
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
