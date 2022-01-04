class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.10.0",
    revision: "79f595d8d194d82e278360d40537c87ea209e889"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.9.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "3ea34957ff1d1c0b1aed80cacfe126365af3433c22275bbff4a4cd037296bd1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b023523808d078042ce1a44ea9c2b2c2c1fdce66b08d8f65b0f49e570f7a8f9f"
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
