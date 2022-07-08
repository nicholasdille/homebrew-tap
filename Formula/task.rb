class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.14.0",
    revision: "d9ec5bcd242975cc131f42c996c82db8c46b47c7"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "804c9824f6c77d9e3d5e8a3449b579959d248860d8fcffe6dcacf1d1c3e1595e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d49a26a3ae14deb6942f459ecce1f9df26b93de3396c7111f37ee4e31b8efe79"
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
