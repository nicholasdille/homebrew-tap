class Havener < Formula
  desc "Swiss army knife for Kubernetes tasks"
  homepage "https://github.com/homeport/havener"

  url "https://github.com/homeport/havener.git",
    tag:      "v2.0.8",
    revision: "93478c612c93dece4cd98f4192fe783ee1dae586"
  license "MIT"
  head "https://github.com/homeport/havener.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/havener-2.0.8"
    sha256 cellar: :any_skip_relocation, big_sur:      "ca7d5bbf1288858a36de2198825b8ddf07db6153933b6cec17acf1b77cca8899"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "649994cb5e08d06f5d61ee1a8db730ca6ed1dcfe1bc36c5e883902899d6814a7"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -extldflags -static " \
                  "-X github.com/homeport/havener/internal/cmd.version=#{version}",
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
