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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.21.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ee05b8e42e3ad1cec684073fa2799ca237c471116cea2cda89141db1d682cb8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d788c42fe0e3dc02c81e732203a7f11d83415441ea97067483b2c326ef2374eb"
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
