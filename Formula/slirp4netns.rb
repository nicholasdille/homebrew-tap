class Slirp4netns < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns/"

  url "https://github.com/rootless-containers/slirp4netns.git",
    tag:      "v1.1.9",
    revision: "4e37ea557562e0d7a64dc636eff156f64927335e"
  license "GPL-2.0-or-later"
  revision 1
  head "https://github.com/rootless-containers/slirp4netns.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/slirp4netns-1.1.9_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "700e12291e25d82d9c3622cb345508514241cf5d1c366554454827de3af98e2f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "glib" => :build
  depends_on "libcap" => :build
  depends_on "libseccomp" => :build
  depends_on "libslirp" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux

  def install
    system "./autogen.sh"
    ENV["LDFLAGS"] = "-static"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"slirp4netns", "--version"
  end
end
