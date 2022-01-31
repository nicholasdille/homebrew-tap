class Chisel < Formula
  desc "Fast TCP/UDP tunnel over HTTP"
  homepage "https://github.com/jpillora/chisel"

  url "https://github.com/jpillora/chisel.git",
    tag:      "v1.7.7",
    revision: "a47b1b318e8017d088bc978703e1212121b38449"
  license "MIT"
  head "https://github.com/jpillora/chisel.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/chisel-1.7.7"
    sha256 cellar: :any_skip_relocation, big_sur:      "6b815038283977f3baeafdb64ee9b6fcb70498e7e0614fb047a7ad982d937796"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fc2e38fb3ab1bc505e6524d64a01dc5e3fef8aeefc9e6546d760846c23b67c71"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/jpillora/chisel"
    commit = Utils.git_short_head

    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -buildid=#{commit}"\
                  " -X #{pkg}/share.BuildVersion=#{version}",
      "-o", bin/"chisel",
      "."
  end

  test do
    system bin/"chisel", "--version"
  end
end
