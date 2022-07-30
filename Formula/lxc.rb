class Lxc < Formula
  desc "Linux Containers"
  homepage "https://linuxcontainers.org/lxc"

  url "https://github.com/lxc/lxc.git",
    tag:      "lxc-4.0.11",
    revision: "48e079bf318982ae7d5684feeb7358870fa71c10"
  license "GPL-2.0-only"
  head "https://github.com/lxc/lxc.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gcc"
  depends_on "libcap"
  depends_on "libseccomp"
  depends_on :linux
  depends_on "openssl@1.1"

  def install
    system "./autogen.sh"
    system "./configure",
      "--prefix=#{prefix}",
      "--with-systemdsystemunitdir=#{etc}/systemd/system",
      "--without-selinux"
    system "make"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name}-ls --version")
  end
end
