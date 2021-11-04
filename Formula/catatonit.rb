class Catatonit < Formula
  desc "Container init that is so simple it's effectively brain-dead"
  homepage "https://github.com/openSUSE/catatonit"

  url "https://github.com/openSUSE/catatonit.git",
    tag:      "v0.1.7",
    revision: "4045634d6255b63d285d73ffc522822a73f4bd03"
  license "GPL-3.0-only"
  head "https://github.com/openSUSE/catatonit.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/catatonit-0.1.7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b3b26745099f66da52a0a852ad21b6d10fcf885959bf8ec17c44e8f2c1611be"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "libtool" => :build
  depends_on "make" => :build
  depends_on :linux

  # Removes duplicate expansion of AM_INIT_AUTOMAKE
  patch :DATA

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

__END__
diff --git a/configure.ac b/configure.ac
index 2842f04..a3b41bc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -31,4 +31,3 @@ AC_FUNC_FORK

 AC_CONFIG_FILES([Makefile config.h])
 AC_OUTPUT
-AM_INIT_AUTOMAKE
