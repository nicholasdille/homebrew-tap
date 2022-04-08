class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.12.2",
    revision: "0e8b121aba103e2053f6bcfebe1a491b43694a30"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.12.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "d5ebdf39f33604aa20bdb741bc84f495389e70923bdab51bdf29e4140ebb3590"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fab01e7cceef6d21f27fb5214dcc589839beca58d78891880486e4798f34dde0"
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
