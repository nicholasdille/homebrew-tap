class Crun < Formula
  desc "Fast and lightweight OCI runtime and C library for running containers"
  homepage "https://github.com/containers/crun"

  url "https://github.com/containers/crun.git",
    tag:      "0.18",
    revision: "808420efe3dc2b44d6db9f1a3fac8361dde42a95"
  license "Apache-2.0"
  head "https://github.com/containers/crun.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "go-md2man" => :build
  depends_on "libcap" => :build
  depends_on "libseccomp" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on "yajl" => :build

  def install
    system "./autogen.sh"
    system "./configure",
      "--prefix=#{prefix}",
      "--disable-systemd"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/crun", "--version"
  end
end
