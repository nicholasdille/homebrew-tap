class Bubblewrap < Formula
  desc "Unprivileged sandboxing tool"
  homepage "https://github.com/containers/bubblewrap/"

  url "https://github.com/containers/bubblewrap.git",
    tag:      "v0.5.0",
    revision: "b84704bb64eac3011f84346c79651c7c1234712c"
  license "LGPL-2.0-or-later"
  head "https://github.com/containers/bubblewrap.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bubblewrap-0.5.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "994b1dbbf5ed55b461f33cb3f2fdb8126aa7f61210bbb504d1c0beef69c6fab6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gcc" => :build
  depends_on "libcap" => :build
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
    system bin/"bwrap", "--version"
  end
end
