class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.77",
    revision: "2ceb5150e2472de4798f47dc54178d6fb7babe51"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.76"
    sha256 cellar: :any_skip_relocation, catalina:     "7e2ec6e77af843793a75facf9332023bbc894c04808baf946c86ad145ac1f5d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9abd4dbfacadc01ae049bb94523bf867cf68c50344763fb776edee3cfa9ea9ff"
  end

  depends_on "go" => :build

  def install
    system "go",
      "mod",
      "tidy"

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o",
      bin/"kubescape",
      "."

    # bash completion
    output = Utils.safe_popen_read(bin/"kubescape", "completion", "bash")
    (bash_completion/"kubescape").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"kubescape", "completion", "fish")
    (zsh_completion/"kubescape.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kubescape", "completion", "zsh")
    (zsh_completion/"_kubescape").write output
  end

  test do
    system bin/"kubescape", "help"
  end
end
