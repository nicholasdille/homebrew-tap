class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.9.0",
    revision: "ad6f100f6a4a7f80dddfa83846b8540d230838f7"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.9.0"
    sha256 cellar: :any_skip_relocation, catalina:     "71ad5755c7e6f385378d3524f1c427c62bbf83f1c3b04705da3c2811a8bbe321"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "166ff3b284d4e26394048fd83415b68ba37541857713ae46cb52e470cbeb7380"
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
