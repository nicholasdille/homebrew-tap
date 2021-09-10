class Gosu < Formula
  desc "Simple Go-based setuid+setgid+setgroups+exec"
  homepage "https://github.com/tianon/gosu"

  url "https://github.com/tianon/gosu.git",
    tag:      "1.14",
    revision: "9f7cd138a1ebc0684d43ef6046bf723978e8741f"
  license "Apache-2.0"
  head "https://github.com/tianon/gosu.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-d -s -w",
      "-o",
      bin/"gosu",
      "."
  end

  test do
    system bin/"gosu", "--version"
  end
end
