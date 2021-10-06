class Catatonit < Formula
  desc "Container init that is so simple it's effectively brain-dead"
  homepage "https://github.com/openSUSE/catatonit"

  url "https://github.com/openSUSE/catatonit.git",
    tag:      "v0.1.6",
    revision: "32421869e1f15ee7fc17e41da749e66ef193cde2"
  license "GPL-3.0-only"
  head "https://github.com/openSUSE/catatonit.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "./autogen.sh"
    ENV["LDFLAGS"] = "-static"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"catatonit", "--version"
  end
end
