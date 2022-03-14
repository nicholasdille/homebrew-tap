class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.12.0",
    revision: "06191dfef3309a34f01a273824716365149e47a2"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "d21f3a0fe02c95034ea59d4153de5ba75edd64abab183928d755239d8d4b02d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cf0cb4e872d5379f3e8eede51ebf45c25de699c8b0b9cec194e3798097785c32"
  end

  depends_on "go" => :build
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
