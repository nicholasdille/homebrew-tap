class Reptyr < Formula
  desc "Reparent a running program to a new terminal"
  homepage "https://github.com/nelhage/reptyr"

  url "https://github.com/nelhage/reptyr.git",
    tag:      "reptyr-0.8.0",
    revision: "d21a9b19df0fdccabd4c308839caf2d1cc66351d"
  license "MIT"
  revision 1
  head "https://github.com/nelhage/reptyr.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/reptyr-0.8.0_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d7aa2516a3a7a745918a69450273397b34992070aa271e61411b05f7922aadbf"
  end

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    ENV["LDFLAGS"] = "-static"
    system "make", "reptyr"
    bin.install "reptyr"

    man1.install "reptyr.1"
    bash_completion.install "reptyr.bash" => "reptyr"
  end

  test do
    system bin/"reptyr", "-v"
  end
end
