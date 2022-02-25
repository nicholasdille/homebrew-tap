class Bubblewrap < Formula
  desc "Unprivileged sandboxing tool"
  homepage "https://github.com/containers/bubblewrap/"

  url "https://github.com/containers/bubblewrap.git",
    tag:      "v0.6.1",
    revision: "a362d3c0ee79097ce2e3fca4ad003f1e96dad472"
  license "LGPL-2.0-or-later"
  head "https://github.com/containers/bubblewrap.git",
  branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bubblewrap-0.6.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eabac858a0350114a5298a42cd5503a321735c61bb8abc823f82585c71e6f0ac"
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
