class HubTool < Formula
  desc "Docker Hub experimental CLI tool"
  homepage "https://github.com/docker/hub-tool"

  url "https://github.com/docker/hub-tool.git",
    tag:      "v0.3.1",
    revision: "700898174bd423a37ef5a15c0948990d5e50921c"
  license "Apache-2.0"
  head "https://github.com/docker/hub-tool.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/hub-tool-0.3.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7d39a2e34770f7bc21e7fa50c07d0e797128ff3569ad23835d964b19df813ca2"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/docker/hub-tool"
    commit = Utils.safe_popen_read(
      "git",
      "rev-parse",
      "HEAD",
    )
    tag = Utils.safe_popen_read(
      "git",
      "describe",
      "--tags",
      "--match",
      "v[0-9]*",
    )
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.GitCommit=#{commit}"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", bin/"hub-tool",
      "."
  end

  test do
    system bin/"hub-tool", "--version"
  end
end
