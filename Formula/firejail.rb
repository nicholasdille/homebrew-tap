class Firejail < Formula
  desc "Linux namespaces and seccomp-bpf sandbox"
  homepage "https://firejail.wordpress.com/"

  url "https://github.com/netblue30/firejail.git",
    tag:      "0.9.70",
    revision: "b4b08d21cd95725c9d55dfdb6987fcc6d7893247"
  license "LGPL-2.0-only"
  head "https://github.com/netblue30/firejail.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firejail-0.9.70"
    sha256 x86_64_linux: "a715facc87f48f24935ed6e0a0637ab85cdc0669f0cbc8d75cc94d3772504243"
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
