class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.27",
    revision: "65fad4bfcb250df0435ea668017e643e7f462155"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git"

  depends_on "gcc" => :build
  depends_on "git" => :build
  depends_on "glib" => :build
  depends_on "libcap" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/runc" => :build
  depends_on "pkg-config" => :build

  def install
    system "make"
    bin.install "bin/conmon"
  end

  test do
    system "#{bin}/conmon", "--version"
  end
end
