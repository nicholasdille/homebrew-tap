class BtrfsProgs < Formula
  desc "Development of userspace BTRFS tools"
  homepage "https://github.com/kdave/btrfs-progs"

  url "https://github.com/kdave/btrfs-progs.git",
    tag:      "v5.10.1",
    revision: "f2ffce38b9c1477a7350bfe165f0e34b9bde40f5"
  license "MIT"
  head "https://github.com/kdave/btrfs-progs.git"

  depends_on "asciidoc" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "e2fsprogs" => :build
  depends_on "gcc@10" => :build
  depends_on "lzo" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.8" => :build
  depends_on "nicholasdille/tap/util-linux" => :build
  depends_on "xmlto" => :build
  depends_on "zstd" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    # system "make", "install"
  end

  test do
    #
  end
end
