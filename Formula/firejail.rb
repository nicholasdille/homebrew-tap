class Firejail < Formula
  desc "Linux namespaces and seccomp-bpf sandbox"
  homepage "https://firejail.wordpress.com/"

  url "https://github.com/netblue30/firejail.git",
    tag:      "0.9.66",
    revision: "a67bb37b0ddac080008cd5cf494aaaf8531f45c0"
  license "LGPL-2.0-only"
  head "https://github.com/netblue30/firejail.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

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
