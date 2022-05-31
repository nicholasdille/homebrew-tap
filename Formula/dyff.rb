class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://github.com/homeport/dyff"

  url "https://github.com/homeport/dyff.git",
    tag:      "v1.5.4",
    revision: "4b398d4df3aa6b443124657c37d3fe788568d1ad"
  license "MIT"
  head "https://github.com/homeport/dyff.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dyff-1.5.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "800443a4e34a7bfaa7f800b337eadc7cb7fd680829409360e794b9ce2600903e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1b1041083f95a71e55ee595c5c95efa2b1f7835a3db258b770747085085fe26c"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -extldflags -static"\
                  " -X github.com/homeport/dyff/internal/cmd.version=#{version}",
      "-o", bin/"dyff",
      "./cmd/dyff/main.go"

    # bash completion
    output = Utils.safe_popen_read(bin/"dyff", "completion", "bash")
    (bash_completion/"dyff").write output

    # fish completion
    output = Utils.safe_popen_read(bin/"dyff", "completion", "fish")
    (zsh_completion/"dyff.fish").write output

    # zsh completion
    output = Utils.safe_popen_read(bin/"dyff", "completion", "zsh")
    (zsh_completion/"_dyff").write output
  end

  test do
    system bin/"dyff", "version"
  end
end
