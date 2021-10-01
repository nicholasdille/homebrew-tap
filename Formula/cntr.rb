class Cntr < Formula
  desc "Container debugging tool based on FUSE"
  homepage "https://github.com/Mic92/cntr"

  url "https://github.com/Mic92/cntr.git",
    tag:      "1.5.1",
    revision: "fdc1463cdfea0d5007c15369703150767869af51"
  license "MIT"
  head "https://github.com/Mic92/cntr.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cntr-1.5.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "836e038ed399dbb716c35c456a37d7694209142b87ab7e8e813f12a37f63cac6"
  end

  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on :linux

  def install
    system "make", "all"
    bin.install "target/release/cntr"
  end

  test do
    system bin/"cntr", "--help"
  end
end
