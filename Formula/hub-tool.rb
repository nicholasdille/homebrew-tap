class HubTool < Formula
  desc "Docker Hub experimental CLI tool"
  homepage "https://github.com/docker/hub-tool"

  url "https://github.com/docker/hub-tool.git",
    tag:      "v0.4.2",
    revision: "133c07e9d2396b89552469d3c47f0461e0c5576d"
  license "Apache-2.0"
  head "https://github.com/docker/hub-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/hub-tool-0.4.1"
    sha256 cellar: :any_skip_relocation, catalina:     "5946a25183d9944026078b6760dcfdfa5a9a20d08fe495918ff494cefed7bb75"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f36d13e0356a8eec6c0d2a5744bda9ea547bb4caba3b8c844540245c29c2958"
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
