class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://github.com/deislabs/oras"

  url "https://github.com/deislabs/oras.git",
    tag:      "v0.11.1",
    revision: "5bfe0ab04a0f6fcdc5de4294cc79fb5b2e23a9a5"
  license "MIT"
  revision 1
  head "https://github.com/deislabs/oras.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oras-0.11.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9e1838a33a5a8aa2a93c9d0e98c58b563a92c48c6ac317e2d6761e665438c224"
  end

  depends_on "go" => :build

  conflicts_with "oras"

  def install
    pkg = "github.com/deislabs/oras"
    commit = Utils.git_short_head
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-w -s"\
                  " -X #{pkg}/internal/version.Version=#{version}"\
                  " -X #{pkg}/internal/version.BuildMetadata=Homebrew"\
                  " -X #{pkg}/internal/version.GitCommit=#{commit}"\
                  " -X #{pkg}/internal/version.GitTreeState=clean",
      "-o", bin/"oras",
      "#{pkg}/cmd/oras"
  end

  test do
    assert_match "#{version}+Homebrew", shell_output("#{bin}/oras version")
  end
end
