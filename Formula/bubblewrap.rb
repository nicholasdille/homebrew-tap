class Bubblewrap < Formula
  desc "Unprivileged sandboxing tool"
  homepage "https://github.com/containers/bubblewrap/"

  url "https://github.com/containers/bubblewrap.git",
    tag:      "v0.6.0",
    revision: "b480c5fd0d383ac5d45b6390bd4b48068de6dd6b"
  license "LGPL-2.0-or-later"
  head "https://github.com/containers/bubblewrap.git",
  branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bubblewrap-0.6.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6cf371976ac2959d3672c97069db7f37e93febd38d78cbcb72c2da1c5c5431b"
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
