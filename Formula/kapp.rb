class Kapp < Formula
  desc "Simple deployment tool focused on the concept of Kubernetes application"
  homepage "https://get-kapp.io/"

  url "https://github.com/vmware-tanzu/carvel-kapp.git",
    tag:      "v0.36.0",
    revision: "9019dcf7ff44c7019867c56256d986e1729c863c"
  license "Apache-2.0"
  revision 1
  head "https://github.com/vmware-tanzu/carvel-kapp.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kapp-0.36.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "447a75bf2ed7f4d00990aaf7c7faeddb016053963a4f96fe97727b1fed5ada2e"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", "#{bin}/kapp",
      "./cmd/kapp"

    # bash completion
    output = Utils.safe_popen_read("#{bin}/kapp", "completion", "bash")
    (bash_completion/"kapp").write output

    # fish completion
    output = Utils.safe_popen_read("#{bin}/kapp", "completion", "fish")
    (fish_completion/"kapp.fish").write output

    # zsh completion
    output = Utils.safe_popen_read("#{bin}/kapp", "completion", "zsh")
    (zsh_completion/"_kapp").write output
  end

  test do
    system "#{bin}/kapp", "--version"
  end
end
