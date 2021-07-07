class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.5.0",
    revision: "3bbbaf12fd1002c6077b39138b1378b105209bbe"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.4.3"
    sha256 cellar: :any_skip_relocation, catalina:     "b259c1b009ece719e70fecca380dcd8489c5e5873fc997db60630fa06ceba550"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "898a9da5255dc20a2075a5c1ae9534ecf15aa4c01fc54cbd7c59d30d95621df0"
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
