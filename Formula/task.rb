class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.11.0",
    revision: "d8555e5a5ded8230b203a995d9b0bd7e62316cfd"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.10.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "f562cdd97fbf22d06141f8a35c3752d3e6e1e63031a4307f5c68824c40e11c37"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2960433fb7aca4a78712a0391522b9eb45015154bf0bc48f666080ee00dfb38"
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
