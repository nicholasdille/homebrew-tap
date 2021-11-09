class Havener < Formula
  desc "Swiss army knife for Kubernetes tasks"
  homepage "https://github.com/homeport/havener"

  url "https://github.com/homeport/havener.git",
    tag:      "v2.0.7",
    revision: "5117deba6f0b015820bc9e6f280637de4948db4d"
  license "MIT"
  head "https://github.com/homeport/havener.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/havener-2.0.6"
    sha256 cellar: :any_skip_relocation, catalina:     "27611f03e7d2fa5416a55feb2cf084b6d6a2f9d674c538e209c16f0b24aa9f1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "62adca12f8480cf8f5a65ee02550b0939c5d3ce24d20e78bda3b4875a20e1b09"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -extldflags -static"\
                  " -X github.com/homeport/havener/internal/cmd.version=#{version}",
      "-o", bin/"havener",
      "./cmd/havener/main.go"

    # bash completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "bash")
    (bash_completion/"havener").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "fish")
    (zsh_completion/"havener.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"havener", "completion", "zsh")
    (zsh_completion/"_havener").write output
  end

  test do
    system bin/"havener", "version"
  end
end
