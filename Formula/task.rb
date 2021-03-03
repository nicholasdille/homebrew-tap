class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.2.2",
    revision: "47d3011c85ea9b8cddb90f611c90145624b38e62"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.2.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0252af3f09720072a65c6b23baaa379fbbccd9661b025d9824ea30a689d0ee00"
  end

  depends_on "git" => :build
  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "log", "-n", "1", "--format=%h")
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags",
      "-w -s -X main.version=#{tag}",
      "-o",
      "#{bin}/task",
      "./cmd/task"
  end

  test do
    system "#{bin}/task", "--version"
  end
end
