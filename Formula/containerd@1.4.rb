class ContainerdAT14 < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.6",
    revision: "d71fcd7d8303cbf684402823e425e9dd2e99285d"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  livecheck do
    url :stable
    regex(/^v(1.4.\d+)/i)
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/runc@100rc"
  depends_on "nicholasdille/tap/cni" => :recommended

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
