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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/hub-tool-0.4.2"
    sha256 cellar: :any_skip_relocation, catalina:     "375bd0029f2eaa198dfb4c7464505eba3296359d29c5aed3b3bcd730228f8a53"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f48c66d063d892f61632668263cda19d44dc564093cd0db81894f7736193f5f"
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
