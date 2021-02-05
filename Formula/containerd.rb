class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io/"
  url "https://github.com/containerd/containerd.git",
    tag: "v1.4.3"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build

  conflicts_with "nicholasdille/tap/containerd-bin"

  def install
    system "make"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    system "#{bin}/containerd", "--version"
  end
end
