class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.3",
    revision: "269548fa27e0089a8b8278fc4fc781d7f65a939b"
  license "Apache-2.0"
  revision 3
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.4.3_3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac6f0de779593b8e238eff9267e10d6e2607102df5063296a2ed1f70fc5cfd4d"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

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

    (var/"run/containerd").mkpath
    (var/"log").mkpath
    (buildpath/"containerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/rootlesskit --state-dir=#{var}/run/rootlesskit/containerd --net=slirp4netns --copy-up=/etc --copy-up=/run --disable-host-loopback #{HOMEBREW_PREFIX}/bin/containerd --config #{etc}/containerd/config.toml
      env:
        XDG_RUNTIME_DIR: #{var}/run/containerd
      pid:
        parent: #{var}/run/containerd/parent.pid
        child: #{var}/run/containerd/child.pid
      log:
        file: #{var}/log/containerd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "containerd.yml"
  end

  test do
    system "#{bin}/containerd", "--version"
  end
end
