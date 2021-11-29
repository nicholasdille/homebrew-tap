class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.9.1",
    revision: "d9859b18fedb9df13df0b4cedeb4d35676724f8e"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.9.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "4c764e77aaae3d80b6385c7d0e42b6aa67cccc4f449632204e6f60fb2c4a3bbf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7105dd46f12a8da9cb10719fc241ea72f5503530844c5cf93fc7513d90cf7c5d"
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
