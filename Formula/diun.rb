class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.17.0",
    revision: "58ca2634aee5ebf8587873d203122089e978934f"
  license "MIT"
  head "https://github.com/crazy-max/diun.git"

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
