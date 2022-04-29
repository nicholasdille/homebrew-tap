class Sshocker < Formula
  desc "Ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.3.0",
    revision: "b8ee047b8074116d90e63cc342b8668f5e77090d"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.2.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "8ffa4dcdf09cf142c90aa1bc2bed511ed563f2f7eba4a9e4a0e0809632781e7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "16654d288a2b3fb30e9269331a83cd8e4cb5e46e1973970a8e25287081b02311"
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
