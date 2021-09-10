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

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/gosu-1.14"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a540844d3aace7b592899f1e6dda5226a7459b5657e5a229466b1f920ea6c5ad"
  end

  depends_on "go" => :build
  depends_on :linux

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
