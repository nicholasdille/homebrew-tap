class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.4.1",
    revision: "ebb66ba8fb19565ab93cae520b05b320260f22f5"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.3.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "568cb694346ae645db2dd9886c18e552330d60b07eb3de20e5ba4b4c7f83ab53"
  end

  depends_on "git" => :build
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
