class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.4.2",
    revision: "f8545d4c61ae59af6adcf35955b549cb0c4ed577"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.4.2"
    sha256 cellar: :any_skip_relocation, catalina:     "3f00c892a18e6c2827ecb5f7c894e88e3240bcc6598d8024113c58f4bb62c340"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2d5a10e15c032e03e625800246a56cd569e78ffe65a62a1ca9ee0a5fa1ef849a"
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
