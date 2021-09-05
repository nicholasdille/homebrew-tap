class Sshocker < Formula
  desc "Ssh + reverse sshfs + port forwarder, in Docker-like CLI"
  homepage "https://github.com/AkihiroSuda/sshocker"

  url "https://github.com/AkihiroSuda/sshocker.git",
    tag:      "v0.2.2",
    revision: "9d10b4ee8dc3159093350fdfe856aca0fccfa6f3"
  license "Apache-2.0"
  head "https://github.com/AkihiroSuda/sshocker.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/sshocker-0.2.2"
    sha256 cellar: :any_skip_relocation, catalina:     "7688b3076704e0100576d7610029412f904e2bc6e0e646c752a1835d6b0dad6a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5b3934515ebd310c47fc846f2a2aa786d9c82c7f3e39a56aae272600e1ca0c7"
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
