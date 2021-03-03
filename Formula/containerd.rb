class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.4",
    revision: "05f951a3781f4f2c1911b05e61c160e9c30eaa8e"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.4.3_3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac6f0de779593b8e238eff9267e10d6e2607102df5063296a2ed1f70fc5cfd4d"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

  depends_on "git" => :build
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
    system "#{bin}/containerd", "--version"
  end
end
