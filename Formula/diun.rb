class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.17.0",
    revision: "58ca2634aee5ebf8587873d203122089e978934f"
  license "MIT"
  head "https://github.com/crazy-max/diun.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.17.0"
    sha256 cellar: :any_skip_relocation, catalina:     "c5365956aa0a560ce64b8d0a46da1ae9fac449cc7e4b651d24924dcf72e98228"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "692d55f85161de3cc1712ae97fc3e6540d3d294f01da0ecba62f8462096a5728"
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
