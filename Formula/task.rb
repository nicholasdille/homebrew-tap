class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.8.0",
    revision: "361b9b4ce4811d51b7b4f9d6b3717d4fac9adf1b"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.8.0"
    sha256 cellar: :any_skip_relocation, catalina:     "9cbceab95acd74aa3a0ccaa8ac59c50583a133f466bc607efd20290da61c6a2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "edc3726045344d83abe965497f82b62ccc80ca93c634a008207f6d956770cb4d"
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
