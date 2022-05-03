class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.6.4",
    revision: "212e8b6fa2f44b9c21b2798135fc6fb7c53efc16"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.6.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "295e3eaad84b0f4c28b59426084b251de8a95ccb8e2662b1e0f0ca8fb1062a7d"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-cri", "Support CRI"

  depends_on "device-mapper" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "make" => :build
  depends_on "pkg-config" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/runc"
  depends_on "nicholasdille/tap/cni" => :recommended

  def install
    ENV["EXTRA_FLAGS"] = "-buildmode=pie"
    ENV["EXTRA_LDFLAGS"] = '-extldflags "-fno-PIC -static"'

    buildtags = [
      "netgo",
      "osusergo",
      "static_build",
    ]
    buildtags << "no_btrfs"     if build.without? "btrfs"
    # buildtags << "no_devmapper" if build.without? "device-mapper"
    buildtags << "no_cri"       if build.without? "cri"

    system "make", "BUILDTAGS=#{buildtags.join(" ")}"
    system "make", "install", "PREFIX=#{prefix}"

    system "make", "man"
    man5.install Dir["man/*.5"]
    man8.install Dir["man/*.8"]

    (buildpath/"containerd.yml").write <<~EOS
      cmd: #{bin}/containerd --config #{etc}/containerd/config.toml
      env:
        XDG_RUNTIME_DIR: #{var}/run/containerd
        XDG_DATA_HOME: #{var}/lib/containerd
        XDG_CONFIG_HOME: #{etc}/containerd
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
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
