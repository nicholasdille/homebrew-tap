class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.12.0",
    revision: "f2abc13ce2e26017b69ea7de1327aa8be7892da5"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4f117ad10d4c7efc9fe1a05cbb4477d79844063e088047dd7dabf4bded05cbe6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "36676c5e558d99e1069c93a514966412357d3bbe432779e53f3012778a6f81aa"
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
