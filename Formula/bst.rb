class Bst < Formula
  desc "One-stop shop for process isolation"
  homepage "https://github.com/aristanetworks/bst"

  url "https://github.com/aristanetworks/bst.git",
    revision: "ffbc8d5adbc460c217ddcdeb4fc57771eedfb6d4"
  version "1.0.0-rc2"
  license "MIT"
  head "https://github.com/aristanetworks/bst.git"

  depends_on "libcap" => :build
  depends_on "libnfnetlink" => :build
  depends_on "linux-headers" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "scdoc" => :build
  depends_on :linux

  def install
    ENV["CPPFLAGS"] = "-Wconversion -pedantic-errors"
    system "meson", "./build"
    system "ninja", "-C", "./build"
    # bin.install ""
  end

  test do
    system bin/"kim", "--version"
  end
end
