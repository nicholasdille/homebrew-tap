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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.3.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "222c38393fa61164aaed6d9e525cc13c5935859b2eaed06e63da943ced3c3bbc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4246ca7e5417f00cce23ffb9866102958ee274f830b611d9803eb1f4700457d8"
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
