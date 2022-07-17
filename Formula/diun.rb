class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.22.0",
    revision: "a6584c05dad63fef7250a8a78e8ebed25eb899a2"
  license "MIT"
  head "https://github.com/crazy-max/diun.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.22.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "279c57f51ead27514545a4608e6045e75e20c3b28a249728d226c74661b8c1b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f3d84156db771c0e231519776caddba65667d92271a56620fb1c6f308db83d82"
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
