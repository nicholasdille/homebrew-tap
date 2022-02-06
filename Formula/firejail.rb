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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firejail-0.9.68"
    sha256 x86_64_linux: "43d9c074d80f4f8e270785722633afe7cea646d7bd4b3751c83e13efdc092972"
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
