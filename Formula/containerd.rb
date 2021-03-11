class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.4",
    revision: "05f951a3781f4f2c1911b05e61c160e9c30eaa8e"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.4.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9612c98b392cfc4c865ba521f733737042006f587e2406de0a8d7d9a1cc5698d"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build

  def install
    dir = buildpath/"src/github.com/containerd/containerd"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      buildtags = []
      buildtags << "no_btrfs"     if build.without? "btrfs"
      buildtags << "no_devmapper" if build.without? "devmapper"
      buildtags << "no_cri"       if build.without? "cri"

      system "make", "binaries", "BUILDTAGS=#{buildtags.join(" ")}"
      system "make", "install", "DESTDIR=#{prefix}"
    end
  end

  test do
    system bin/"containerd", "--version"
  end
end
