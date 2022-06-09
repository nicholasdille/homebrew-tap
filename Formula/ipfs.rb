class Ipfs < Formula
  desc "Global, versioned, peer-to-peer filesystem"
  homepage "https://ipfs.io/"

  url "https://github.com/ipfs/go-ipfs.git",
    tag:      "v0.13.0",
    revision: "c9d51bbe0133968858aa9991b7f69ec269126599"
  license "MIT"
  license "Apache-2.0"
  head "https://github.com/ipfs/go-ipfs.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ipfs-0.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "cc1160bdc92f960f5704292126a59bdc315bc80f60bcd785bf028b8a2d29d5dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c9105f96dee226be57ceda39922abee6c8b4384c3e3fc92a59fd445cb569f39c"
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
