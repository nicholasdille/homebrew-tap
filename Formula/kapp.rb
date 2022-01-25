class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.45.0",
    revision: "edeb9dd9a923e15187f88999e983cb5762a14faa"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.45.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "2890c5f806b58c11cf98ff002ab2ad13d2f7a57b6b68edb78c8ad0b7dd454e91"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9912b3f438bd06463df95ca3a1633d83cc9113c1e54558c5259cd6601af15d4"
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
