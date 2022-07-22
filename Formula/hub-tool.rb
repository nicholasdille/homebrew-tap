class HubTool < Formula
  desc "Docker Hub experimental CLI tool"
  homepage "https://github.com/docker/hub-tool"

  url "https://github.com/docker/hub-tool.git",
    tag:      "v0.4.5",
    revision: "d383e722fffcd4f0c7ccf835aace7138abb2e937"
  license "Apache-2.0"
  head "https://github.com/docker/hub-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/hub-tool-0.4.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "e6a5ea214f16c049051931d2b9ec379ccb1e4520760bdb4a38288a1cb188baa4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "30af503e58d14445bf19abe8fe2823a1bc7e703f7ff7754ce95a7df1c4fc8ba7"
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
      "-ldflags", "-s -w " \
                  "-X #{pkg}/internal.GitCommit=#{commit} " \
                  "-X #{pkg}/internal.Version=#{tag}",
      "-o", bin/"hub-tool",
      "."
  end

  test do
    system bin/"hub-tool", "--version"
  end
end
