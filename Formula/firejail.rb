class Firejail < Formula
  desc "Linux namespaces and seccomp-bpf sandbox"
  homepage "https://firejail.wordpress.com/"

  url "https://github.com/netblue30/firejail.git",
    tag:      "0.9.68",
    revision: "0845233a630a1f4224a83ae870b2d6141f978059"
  license "LGPL-2.0-only"
  head "https://github.com/netblue30/firejail.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firejail-0.9.68_1"
    sha256 x86_64_linux: "9a752652c90f74a0d6f5d8d997cbcd3a54cc9e4868d966079e044200d441f286"
  end

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install-strip"
  end

  test do
    system "whereis", "firejail"
  end
end
