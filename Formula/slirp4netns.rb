class Slirp4netns < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns"

  url "https://github.com/rootless-containers/slirp4netns.git",
    tag:      "v1.1.8",
    revision: "d361001f495417b880f20329121e3aa431a8f90f"
  license "GPL-2.0-or-later"
  head "https://github.com/rootless-containers/slirp4netns.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/slirp4netns-1.1.8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ee33373c0a8764e25e59247ecb8ab1a77896226bd5d696a7b811f78a57f0a6f"
  end

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
