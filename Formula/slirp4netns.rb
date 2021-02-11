class Slirp4netns < Formula
  desc "User-mode networking for unprivileged network namespaces."
  homepage "https://github.com/rootless-containers/slirp4netns"

  url "https://github.com/rootless-containers/slirp4netns.git",
    tag:      "v1.1.8",
    revision: "d361001f495417b880f20329121e3aa431a8f90f"
  license "GPL-2.0-or-later"
  head "https://github.com/rootless-containers/slirp4netns.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "glib" => :build
  depends_on "libcap" => :build
  depends_on "libseccomp" => :build
  depends_on "libslirp" => :build
  depends_on "pkg-config" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/slirp4netns", "--version"
  end
end
