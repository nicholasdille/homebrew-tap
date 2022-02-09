class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v2.0.145",
    revision: "bd9ade4d151e734a68665442a43249215436203a"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-2.0.144"
    sha256 cellar: :any_skip_relocation, big_sur:      "0649e4ce702dbc6225f044127fea34eaeeb1e6a401439008a00a39c8c40e1aa5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5bbbde3880e64655dcaada56e5b6fbaa0c6069935970eb663adb22a1e91f3a39"
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
