class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.40.0",
    revision: "0dbf7046f54ad192b9e9e3e14445fe379ad77a98"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.39.0"
    sha256 cellar: :any_skip_relocation, catalina:     "66c12a6464633426280840494ca997fa0ebecb78f1f4acaf2c8685630bf7c445"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "866ef5c079c484b88b3861c9d3e3135ab6aedbdf1051083148d640e649e56642"
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
