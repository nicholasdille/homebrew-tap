class Norouter < Formula
  desc "IP-over-Stdio. The easiest multi-host & multi-cloud networking ever"
  homepage "https://norouter.io/"

  url "https://github.com/norouter/norouter.git",
    tag:      "v0.6.2",
    revision: "7a98d9843bd0785a7c0920331649c5efb9002873"
  license "Apache-2.0"
  head "https://github.com/norouter/norouter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/norouter-0.6.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bf79a52b7248d3a8fb0af92b31b8180bcb014fc484c1f845e5b08909dc1f83b1"
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"norouter",
      "./cmd/norouter"
  end

  test do
    system bin/"norouter", "--version"
  end
end
