class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.37.0",
    revision: "7f2ed9335c6b3fe050222828babd08735e28a7d7"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-kapp.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.37.0"
    sha256 cellar: :any_skip_relocation, catalina:     "5a93ae8945cc51efc98b72f82c7f89c37e19bd9a26c11a7014530ae9afdfc5f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "17b96acd58e6f3e6696165fbcc4e63f84e46511265d1ecc27bc63e1afe3c2b88"
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
