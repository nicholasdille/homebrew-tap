class Kustomizer < Formula
  desc "Build, diff, apply, prune CLI for Kubernetes manifests and Kustomize overlays"
  homepage "https://kustomizer.dev/"

  url "https://github.com/stefanprodan/kustomizer.git",
    tag:      "v1.0.0",
    revision: "43977b18ecb25b22b3023837fc5e1cce0bdaf249"
  license "Apache-2.0"
  head "https://github.com/stefanprodan/kustomizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kustomizer-1.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e004b34cd3789030f5a683471815f5d22a2e4ddc0501acc160a52bb79d12005d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "73d0e9c38b7c9dc755c89c828a8132176c70a01fb3ada9d007af189542e0479d"
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
