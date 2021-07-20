class Sshocker < Formula
  desc "Ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.1.0",
    revision: "006b942173f1d9511a9cb1eb9d5ee97e7352b5a0"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.1.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d410165c0243fd27bc28c05496c2d34626a7912f7b60db55fb80994153af7cf9"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make"

    bin.install "bin/sshocker"
  end

  test do
    system bin/"sshocker", "--version"
  end
end
