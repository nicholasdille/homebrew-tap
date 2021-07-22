class Reptyr < Formula
  desc "Reparent a running program to a new terminal"
  homepage "https://github.com/nelhage/reptyr"

  url "https://github.com/nelhage/reptyr.git",
    tag:      "reptyr-0.8.0",
    revision: "d21a9b19df0fdccabd4c308839caf2d1cc66351d"
  license "MIT"
  head "https://github.com/nelhage/reptyr.git"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    ENV["LDFLAGS"] = "-static"
    system "make", "reptyr"
    bin.install "reptyr"
  end

  test do
    system bin/"reptyr", "-v"
  end
end
