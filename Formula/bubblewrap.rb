class Bubblewrap < Formula
  desc "Unprivileged sandboxing tool"
  homepage "https://github.com/containers/bubblewrap/"

  url "https://github.com/containers/bubblewrap.git",
    tag:      "v0.4.1",
    revision: "5feb64dc60c936a7f9e424df9478aae9b88ee48a"
  license "LGPL-2.0-or-later"
  head "https://github.com/containers/bubblewrap.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/bubblewrap-0.4.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "63f0808f5c24be0b7beb880461c9cba763c64eff5ad1d28e90c006515f0c0ee6"
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
