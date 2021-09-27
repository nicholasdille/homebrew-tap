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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.7.3"
    sha256 cellar: :any_skip_relocation, catalina:     "1caa5394461b1b240bb9403b681dcaaccbfa429ed6dd8fdfab8e10f9f4763fdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2509ce6f5394a21d1dd62c09ae0143d73d918203f705a20a4dda5649d4404c28"
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
