class Slirp4netns < Formula
  desc "User-mode networking for unprivileged network namespaces"
  homepage "https://github.com/rootless-containers/slirp4netns/"

  url "https://github.com/rootless-containers/slirp4netns.git",
    tag:      "v1.2.0",
    revision: "656041d45cfca7a4176f6b7eed9e4fe6c11e8383"
  license "GPL-2.0-or-later"
  head "https://github.com/rootless-containers/slirp4netns.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/slirp4netns-1.2.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fdf6978445965a7271609060b9770329aac044afa617273f2828596496cb7ef0"
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
