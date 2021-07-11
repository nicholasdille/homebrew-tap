class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.6.0",
    revision: "239e61e71884337d56a6e8df6c83beeca45baca8"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.5.0"
    sha256 cellar: :any_skip_relocation, catalina:     "86fb74ee971d6f36c56fc04eab76c3ad4c43a1f0bc39629cc25c0058094e7286"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a61a8b9f15884a5bc459bce79b90a558f34366d6eae363ac8216040397bb22ed"
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
