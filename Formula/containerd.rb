class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.3",
    revision: "269548fa27e0089a8b8278fc4fc781d7f65a939b"
  license "Apache-2.0"
  revision 4
  head "https://github.com/containerd/containerd.git"

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
      ENV["GOPATH"] = buildpath

      buildtags = []
      buildtags << "no_btrfs" if build.without? "btrfs"
      buildtags << "no_devmapper" if build.without? "devmapper"
      buildtags << "no_cri" if build.without? "cri"

      system "make", "binaries", "BUILDTAGS=#{buildtags.join(" ")}"
      system "make", "install", "DESTDIR=#{prefix}"
    end
  end

  def caveats
    <<~EOS
      TODO: brew immortal
      TODO: nsenter -U --preserve-credentials -m -n -t $(cat /home/linuxbrew/.linuxbrew/var/run/rootlesskit/containerd/child_pid)
      TODO: export CONTAINERD_ADDRESS=/home/linuxbrew/.linuxbrew/var/run/containerd/containerd.sock
      TODO: export CONTAINERD_SNAPSHOTTER=native
      TODO: ctr images pull docker.io/library/alpine:latest
      TODO: ctr run -t --rm --fifo-dir /tmp/foo-fifo --cgroup "" docker.io/library/alpine:latest foo
    EOS
  end

  test do
    system "#{bin}/containerd", "--version"
  end
end
