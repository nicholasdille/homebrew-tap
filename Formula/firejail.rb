class Firejail < Formula
  desc "Linux namespaces and seccomp-bpf sandbox"
  homepage "https://firejail.wordpress.com/"

  url "https://github.com/netblue30/firejail.git",
    tag:      "0.9.64.4",
    revision: "b818fc40cef9865b3202b7de227348dd26acf9fd"
  license "LGPL-2.0-only"
  head "https://github.com/netblue30/firejail.git"

  bottle :unneeded

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install-strip"
  end

  test do
    system "whereis", "firejail"
  end
end
