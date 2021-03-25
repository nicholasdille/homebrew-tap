class Bubblewrap < Formula
  desc "Unprivileged sandboxing tool"
  homepage "https://github.com/containers/bubblewrap/"

  url "https://github.com/containers/bubblewrap.git",
    tag:      "v0.4.1",
    revision: "5feb64dc60c936a7f9e424df9478aae9b88ee48a"
  license "LGPL-2.0-or-later"
  head "https://github.com/containers/bubblewrap.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "libcap" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    system "./autogen.sh"
    ENV["LDFLAGS"] = "-static"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"bwrap", "--version"
  end
end
