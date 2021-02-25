class HubTool < Formula
  desc "Docker Hub experimental CLI tool"
  homepage "https://github.com/docker/hub-tool"

  url "https://github.com/docker/hub-tool.git",
    tag:      "v0.3.0",
    revision: "4b740d34be5fd13dbd565a49c6fa4c9f6e38c072"
  license "Apache-2.0"
  head "https://github.com/docker/hub-tool.git"

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
      "-ldflags",
      "-s -w -X #{pkg}/internal.GitCommit=#{commit} -X #{pkg}/internal.Version=#{tag}",
      "-o",
      "#{bin}/hub-tool",
      "."
  end

  test do
    system "#{bin}/hub-tool", "--version"
  end
end
