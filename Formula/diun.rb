class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.19.0",
    revision: "28d15947bf65a94f7cc921c03cbf23df67bbce44"
  license "MIT"
  head "https://github.com/crazy-max/diun.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.19.0"
    sha256 cellar: :any_skip_relocation, catalina:     "3366fd4e5151310ac10b2dff898957eeede92ccb649393d16578c2d262c2e248"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "909df43881585a767af396278493da5d8353aaf43cf1fc591572681d5c0c1be4"
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
