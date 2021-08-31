class Sshocker < Formula
  desc "Ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.2.0",
    revision: "15054fbfd23d8a20d5ade832c86de67faada0281"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "72bc128e8964d281065ad8c57d1aed0c02ea38d610599cd7d04cd9bb4ca13e05"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1415248dc1a59aa8a4ca9db441771c09f033eed280c2ae9ad2f6f38eb0b04082"
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
