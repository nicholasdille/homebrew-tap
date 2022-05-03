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

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    cd "cmd" do
      system "go", "build",
        "-ldflags", "-s -w"\
                    " -X github.com/armosec/kubescape/core/cautils.BuildNumber=v#{version}",
        "-o", bin/"kubescape"
    end
  end

  def post_install
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
