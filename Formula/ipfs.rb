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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.12.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "f6b0796fe62bf4eebbb308ec96e247fac5baf03c859122596fc1a761a95075d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2e8689de9873bb51b9e4f7f2031cc29df28c328a4afa321927261772385d4362"
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
