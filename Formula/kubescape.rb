class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.139",
    revision: "d3bdbf31ac5b53b3beaf5b17c48f3b596e1a39a7"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.139"
    sha256 cellar: :any_skip_relocation, big_sur:      "770aedefb925566b58d0c52ee269bbba6b471a9285e1595ee5fe4bbcf5a85fdc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e575831d52fabad9ced9141d4dea0ce79a769df89497459b553e892484d39b91"
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
