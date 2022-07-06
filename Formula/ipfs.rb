class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.13.1",
    revision: "8ffc7a8a6c0d9ecdffd3624688fbf0cf348752d2"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.13.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "f8d7f0659375f926cfc322a7c71850e8987095cc8a42cd0e0dedb00a0e528673"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8b87815d1750aba72b190961be21de07871ef7f4310d6a536493d38ec630f420"
  end

  depends_on "go@1.17" => :build
  depends_on "make" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "make", "build"
    bin.install "cmd/ipfs/ipfs"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} version")
  end
end
