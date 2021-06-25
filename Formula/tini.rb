class Tini < Formula
  desc "Tiny but valid init for containers"
  homepage "https://github.com/krallin/tini"

  url "https://github.com/krallin/tini.git",
    tag:      "v0.19.0",
    revision: "de40ad007797e0dcd8b7126f27bb87401d224240"
  license "MIT"
  head "https://github.com/krallin/tini.git"

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "cmake", "."
    system "make", "tini-static"
    bin.install "tini-static" => "tini"
  end

  test do
    system bin/"tini", "--version"
  end
end
