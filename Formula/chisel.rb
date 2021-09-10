class Chisel < Formula
  desc "Fast TCP/UDP tunnel over HTTP"
  homepage "https://github.com/jpillora/chisel"

  url "https://github.com/jpillora/chisel.git",
    tag:      "v1.7.6",
    revision: "02a4be16607c0655cb55d87b28201b618b98ae75"
  license "MIT"
  head "https://github.com/jpillora/chisel.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
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
