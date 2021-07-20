class ContainerdAT14 < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.8",
    revision: "7eba5930496d9bbe375fdf71603e610ad737d2b2"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  livecheck do
    url :stable
    regex(/^v(1.4.\d+)/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd@1.4-1.4.8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "067ed28fb7bff814b40712b6c6a2806c690888f515a52ba55f950578ac98e6f8"
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
  depends_on "nicholasdille/tap/runc@1.0.0-rc"
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
