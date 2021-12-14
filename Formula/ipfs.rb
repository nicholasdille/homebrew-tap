class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.11.0",
    revision: "67220edaaef4a938fe5fba85d793bfee59db3256"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
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
