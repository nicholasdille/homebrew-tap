class HubTool < Formula
  desc "Docker Hub experimental CLI tool"
  homepage "https://github.com/docker/hub-tool"

  url "https://github.com/docker/hub-tool.git",
    tag:      "v0.4.4",
    revision: "c9cb0ac822ad431a252d462d80ab0dcc21d49e6f"
  license "Apache-2.0"
  head "https://github.com/docker/hub-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/hub-tool-0.4.3"
    sha256 cellar: :any_skip_relocation, catalina:     "23cf7bf970b57dc0a88a52c55bc67207894a26017c46f6100b61b1b88dade40a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0ffdb79707153bac4a2fb18ff6762fcfa0abe5671803900a1dbf86e0403e3e6e"
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
