class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.4.2",
    revision: "f8545d4c61ae59af6adcf35955b549cb0c4ed577"
  license "MIT"
  head "https://github.com/go-task/task.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.4.1"
    sha256 cellar: :any_skip_relocation, catalina:     "3a08b28053382765d0d8be505cf0feed8e54f227e7514f8f78cf756feae39224"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "27eb50cfb52ebeff44e4cab3318b7a06e6fba178564d0ccc271772501cb0c4dc"
  end

  depends_on "git" => :build
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
