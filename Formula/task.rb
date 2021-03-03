class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.2.2",
    revision: "47d3011c85ea9b8cddb90f611c90145624b38e62"
  license "MIT"
  head "https://github.com/go-task/task.git"

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
