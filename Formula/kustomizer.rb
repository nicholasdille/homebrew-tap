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
