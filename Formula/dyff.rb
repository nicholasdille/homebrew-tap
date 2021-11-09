class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://github.com/homeport/dyff"

  url "https://github.com/homeport/dyff.git",
    tag:      "v1.4.6",
    revision: "bd597f335e9538697c4d51b9db7115b6e378530b"
  license "MIT"
  head "https://github.com/homeport/dyff.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dyff-1.4.5"
    sha256 cellar: :any_skip_relocation, catalina:     "e7de3f94267bb6ce5e678814063442e294484b71f73ecf12ee941c1645b99d2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2a849b106b8ce4dff7d0e1fcfbaeb789186cc33870498a2fce41ad975dd43fb5"
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
