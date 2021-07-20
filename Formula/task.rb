class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.6.0",
    revision: "239e61e71884337d56a6e8df6c83beeca45baca8"
  license "MIT"
  head "https://github.com/go-task/task.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.6.0"
    sha256 cellar: :any_skip_relocation, catalina:     "ef5803d58751bfe19e1a251b627fde32629f72b8c12f4f3c493adfdec9c74597"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1a50cea42181ac5a9bc85ff45ecb4d9aaedf44e50141d644c5dedf2bd1669557"
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
