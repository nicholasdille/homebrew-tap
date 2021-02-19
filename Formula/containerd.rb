class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io/"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.4.3",
    revision: "269548fa27e0089a8b8278fc4fc781d7f65a939b"
  license "Apache-2.0"
  revision 3
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.4.3_2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "61745f675690afc4a07be3716688a330f9dd1398afefacb96c52ad7e092f30c4"
  end

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
      buildtags << "no_btrfs"

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
