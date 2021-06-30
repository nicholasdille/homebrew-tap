class Oras < Formula
  desc "OCI Registry As Storage"
  homepage "https://oras.land/"

  url "https://github.com/deislabs/oras.git",
    tag:      "v0.12.0",
    revision: "1e6a64e1789f5145bf669b75bebfe013100f6253"
  license "MIT"
  head "https://github.com/oras-project/oras.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/oras-0.12.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "962cabcd2bb0da09264c984b67487b807baa6b227395c89469f22b8549584ce6"
  end

  depends_on "go" => :build

  conflicts_with "oras"

  def install
    pkg = "github.com/oras-project/oras"
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
