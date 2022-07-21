class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.14.0",
    revision: "e0fabd6dbf69624a259dd735065465e09ebb0a61"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.14.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "683b61c728e74b1b246143c7dd975fd59277338deeec0a8c3b07c79a41d4bac1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1f301ceaaa51a2da53b1fef695fa6ea629d02125b1bcc54e8f2ce4a9a913b208"
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
