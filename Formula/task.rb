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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.14.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "af4e89cbc4773ee1062106a0d5065d93e0c7d71c53cbcd9372d045cdee5e22f1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c344c4f1312f74ccac740e452405aca354d5437634badfd20cfca0bdfb0a80e5"
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
