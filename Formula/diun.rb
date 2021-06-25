class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.18.0",
    revision: "c7ece21f07993867856d5f44517ca7ea959c8fa5"
  license "MIT"
  head "https://github.com/crazy-max/diun.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.18.0"
    sha256 cellar: :any_skip_relocation, catalina:     "2dc13bfb143f114e73ed64fbb8092afb129c51c91c37f2d593955e1ca9342425"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4df328a25c486aec21aac62f20df1d8dbf093c7cf5866305285e6fe0d690581f"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "mod", "tidy"
    system "go", "mod", "download"
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"diun",
      "./cmd"
  end

  test do
    system bin/"diun", "--version"
  end
end
