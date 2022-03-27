class Kubescape < Formula
  desc "Test if Kubernetes is deployed securely"
  homepage "https://github.com/armosec/kubescape"

  url "https://github.com/armosec/kubescape.git",
    tag:      "v2.0.150",
    revision: "cb424eab00b973dcc50989a195f1db6c53bb78f9"
  license "Apache-2.0"
  head "https://github.com/armosec/kubescape.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kubescape-2.0.149"
    sha256 cellar: :any_skip_relocation, big_sur:      "f104e75c198a74655e558aeabbf0d25bb183a60b3fff06ad5177817276b73f1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4ccb030c5c6b8d0d295251500005db1e10e29ce1fdc220d47aa03e9f01c3bcd9"
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
