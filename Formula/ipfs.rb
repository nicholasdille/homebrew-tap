class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.12.1",
    revision: "da2b9bd71aa5d02203be5a0b67f8a9116e8535f5"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8d87bf429b72b53912a64c6f61eaf0f3c398f28a28d6bae2e8457946ea96792d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "659039a5cd69491ca1479d24bf5f33a644a1813189a1d67782dd05147c713ce1"
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
