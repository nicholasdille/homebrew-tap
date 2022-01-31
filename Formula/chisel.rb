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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/chisel-1.7.6"
    sha256 cellar: :any_skip_relocation, catalina:     "bb63cc6dd37ecf04c1f7a803cc1b30a1bad1e5626d16984f52a6c680cc269329"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8551cb65153661285291e38081e716d61f91eed44d90ee604bca6ed61c7c7bdc"
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
