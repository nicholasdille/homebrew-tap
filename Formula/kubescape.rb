class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v2.0.152",
    revision: "cf086e6614ca440f4899ec261790f4aa8cb42b33"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-2.0.150"
    sha256 cellar: :any_skip_relocation, big_sur:      "350e39760baee8fca6ea116ce93bef37df7ce7633e8b4ab693cc694fce4f11d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fd6dbbe8d9a9c3810651e23456f71c1bfafe8b7506a2f98110dbb9cdcc3e4a04"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    cd "cmd" do
      system "go", "build",
        "-ldflags", "-s -w"\
                    " -X github.com/armosec/kubescape/core/cautils.BuildNumber=v#{version}",
        "-o", bin/"kubescape"
    end

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
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
