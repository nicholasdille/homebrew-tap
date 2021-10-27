class Nsutils < Formula
  desc "Linux namespace utilities"
  homepage "https://github.com/rd235/nsutils"

  url "https://github.com/rd235/nsutils.git",
    tag: "master"
  version "0.0.0"
  license "GPL-2.0-only"

  livecheck do
    skip "???"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    system "autoreconf", "-if"
    system "./configure", "--prefix=#{prefix}"
    system "make"
  end

  test do
    system bin/"bin", "--version"
  end
end
