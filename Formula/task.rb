class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.7.0",
    revision: "ad05432bcf3d38f4a2fe55189a19c62fb295aed0"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.7.0"
    sha256 cellar: :any_skip_relocation, catalina:     "26b470293fdf1364f982265bfac296e82e555c9ad62b51d0291653dce04a77e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "85327f60b772b84c646504946f7a0a966c0cfe504f8fea1255bb1061198c510e"
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
