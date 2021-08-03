class Slirp4netns < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns/"

  url "https://github.com/rootless-containers/slirp4netns.git",
    tag:      "v1.1.12",
    revision: "7a104a101aa3278a2152351a082a6df71f57c9a3"
  license "GPL-2.0-or-later"
  head "https://github.com/rootless-containers/slirp4netns.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/slirp4netns-1.1.11"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f732961082ca787d58c4c23979d82ccd486b0a41546cf542a1cd0c7f6f7f55a6"
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
