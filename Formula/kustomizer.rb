class Kustomizer < Formula
  desc "Build, diff, apply, prune CLI for Kubernetes manifests and Kustomize overlays"
  homepage "https://kustomizer.dev/"

  url "https://github.com/stefanprodan/kustomizer.git",
    tag:      "v1.1.3",
    revision: "70d60849dd741dc843119a019ed402219b2a6fd4"
  license "Apache-2.0"
  head "https://github.com/stefanprodan/kustomizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kustomizer-1.1.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "ad4b7150c78f59b667bccc1096cb4692951df17afbbcac4f5dd6ed00920b69c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa4a551bb261a5cb72d4524d13417c39d75b7c788b146aabd18bfb1172dccc5c"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.VERSION=#{version}",
      "-o", bin/"kustomizer",
      "./cmd/kustomizer"

    # bash completion
    output = Utils.safe_popen_read(bin/"kustomizer", "completion", "bash")
    (bash_completion/"kustomizer").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"kustomizer", "completion", "fish")
    (zsh_completion/"kustomizer.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"kustomizer", "completion", "zsh")
    (zsh_completion/"_kustomizer").write output
  end

  test do
    system bin/"kustomizer", "--version"
  end
end
