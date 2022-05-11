class Task < Formula
  desc "Simpler Make alternative written in Go"
  homepage "https://taskfile.dev/"

  url "https://github.com/go-task/task.git",
    tag:      "v3.12.1",
    revision: "ad0b269d533b2a37244257c3868fa4112f3ddc8a"
  license "MIT"
  head "https://github.com/go-task/task.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/task-3.12.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "891351d0591fb157dfafb50e155379f936e543e68dc427bba93cadfde25c7c64"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c87fd8031aab2a57968acf4655a483ccd403c48da9a4f569199f2286343fe56a"
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
