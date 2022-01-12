class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://github.com/homeport/dyff"

  url "https://github.com/homeport/dyff.git",
    tag:      "v1.4.7",
    revision: "737524b9557934641c5f7759be84a5b064fe0f0a"
  license "MIT"
  head "https://github.com/homeport/dyff.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dyff-1.4.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "f06cd5e2d3596783092d0c3ac52494512befd0470c7211b138cc8140b5dfdc43"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "86ea8073ae06f521f3591d2e794b0993b333a5a7944ef48ecb3f3df062dd1bd9"
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
