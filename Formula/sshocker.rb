class Sshocker < Formula
  desc "Ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.2.1",
    revision: "2ad309c8547b756819c3db393847d4058e024f4c"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.2.1"
    sha256 cellar: :any_skip_relocation, catalina:     "96fc0e7c39b54ce52f8170f6270d23823aa2c9e5c36ac0ba8a505a8cdf9bc790"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dd7b8e5cfff8fa363ddf72ba04ccfa61ec52c547beb7700f69c982f822d8916a"
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
