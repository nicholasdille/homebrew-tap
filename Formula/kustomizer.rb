class Kustomizer < Formula
  desc "Build, diff, apply, prune CLI for Kubernetes manifests and Kustomize overlays"
  homepage "https://kustomizer.dev/"

  url "https://github.com/stefanprodan/kustomizer.git",
    tag:      "v1.1.1",
    revision: "830eede65b90379ebfb73b80d4727d512092de01"
  license "Apache-2.0"
  head "https://github.com/stefanprodan/kustomizer.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kustomizer-1.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "b1de3497cf8f7420e1a97bd39ae0c2811776c133dfe3afc217835a4154234c49"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d17fc13caa6cafe0cfd8bc24a66579305dbb63c043f6525dbd934757587716f9"
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
