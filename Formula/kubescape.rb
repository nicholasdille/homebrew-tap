class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v1.0.123",
    revision: "42929dac58b43ad71fc302539a8b31194be3908f"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-1.0.123"
    sha256 cellar: :any_skip_relocation, big_sur:      "888447380a84b55778e3f6116e5d6fe5be45f03b54d8be0711c888b97cde1a67"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee03b5754fe051284bbddb4cbbe2cbc1f947e9f2748aae0e69bbd961bdc0d7fd"
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
