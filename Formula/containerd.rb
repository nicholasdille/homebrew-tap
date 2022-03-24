class Containerd < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/containerd.git",
    tag:      "v1.6.2",
    revision: "de8046a5501db9e0e478e1c10cbcfb21af4c6b2d"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-1.6.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "30c4a2e5b73665c52c6607c435089ae470c781ddcdff32b78bdc8f38ab71e811"
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
