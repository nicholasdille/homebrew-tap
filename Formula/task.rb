class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.11.0",
    revision: "d8555e5a5ded8230b203a995d9b0bd7e62316cfd"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "104721bdbb3fa37e4bf5680231c0c70797af9c38210ec5a7cd06b500ed37bc9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "07b98bdc110df649d31dbb6cd6ae94475b4edd738df673ec1832f5c046179142"
  end

  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "log", "-n", "1", "--format=%h")
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-w -s -X main.version=#{tag}",
      "-o", bin/"task",
      "./cmd/task"
  end

  test do
    system bin/"task", "--version"
  end
end
