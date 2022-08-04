class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.14.1",
    revision: "6cfdb213134566219aa6ca16074408e9f3d44d8f"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.14.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "fa102702d71a620ac36cc21b1e1a72f09055d0e74baa4900b6d53cc2145d3f6f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0e518090793ddf2185625aabf5c35796137f22a3d587b71241111fe4d5ddff1b"
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
