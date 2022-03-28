class Dyff < Formula
  desc "Diff tool for YAML files, and sometimes JSON"
  homepage "https://github.com/homeport/dyff"

  url "https://github.com/homeport/dyff.git",
    tag:      "v1.5.2",
    revision: "a5649a8045adeefcbede5094a5f796284f1a3d77"
  license "MIT"
  head "https://github.com/homeport/dyff.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/dyff-1.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "60dc5f0c5f37ae30b17322bf2da7879d09b24e8680387d14d1f43f598b3e0717"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d564432f67c311b7cabb8ca1fecff656278094bb4aa654f6e390e8710cde11d8"
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
