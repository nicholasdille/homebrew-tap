class ContainerdRootless < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.12.0",
    revision: "aab5de3ae24e7203307cbb030b1114d652f0be01"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git",
    branch: "master"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-rootless-0.12.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "159cb949ba1de0205d58b3dc568ccb456512f8a1f5b27eabac04906b0760c471"
  end

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    bin.install "extras/rootless/containerd-rootless.sh"

    (buildpath/"containerd-rootless.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/containerd-rootless.sh --config #{etc}/containerd/config.toml
      env:
        XDG_RUNTIME_DIR: #{var}/run/containerd-rootless
        XDG_DATA_HOME: #{var}/lib/containerd-rootless
        XDG_CONFIG_HOME: #{etc}/containerd-rootless
      pid:
        parent: #{var}/run/containerd-rootless/parent.pid
        child: #{var}/run/containerd-rootless/child.pid
      log:
        file: #{var}/log/containerd-rootless.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "containerd-rootless.yml"

    (buildpath/"config.toml").write Utils.safe_popen_read(
      HOMEBREW_PREFIX/"bin/containerd",
      "config",
      "default",
    )
    system "sed",
      "-i",
      "-E",
      "s|(/var)?/run/containerd|/home/linuxbrew/.linuxbrew/var/run/containerd|",
      buildpath/"config.toml"
    system "sed",
      "-i",
      "-E",
      "s|/var/lib/containerd|/home/linuxbrew/.linuxbrew/var/lib/containerd|",
      buildpath/"config.toml"
    system "sed",
      "-i",
      "-E",
      "s|/opt/cni/bin|/home/linuxbrew/.linuxbrew/bin|",
      buildpath/"config.toml"
    system "sed",
      "-i",
      "-E",
      "s|/etc/cni/net.d|/home/linuxbrew/.linuxbrew/etc/cni/net.d|",
      buildpath/"config.toml"
    system "sed",
      "-i",
      "-E",
      "s|/etc/containerd|/home/linuxbrew/.linuxbrew/etc/containerd|",
      buildpath/"config.toml"
    (etc/"containerd-rootless").install "config.toml"
  end

  def post_install
    (var/"run/containerd").mkpath
    (var/"log").mkpath
  end

  def caveats
    <<~EOS
      - You can now run rootless buildkitd using immortal
      - It is recommended to use nerdctl
      - If using ctr:
          $ nsenter -U --preserve-credentials -m -n -t $(cat #{var}/run/containerd-rootless/containerd-rootless/child_pid)
          $ export CONTAINERD_ADDRESS=#{var}/run/containerd-rootless/containerd.sock
          $ export CONTAINERD_SNAPSHOTTER=native
          $ ctr images pull docker.io/library/alpine:latest
          $ ctr run -t --rm --fifo-dir /tmp/foo-fifo --cgroup "" docker.io/library/alpine:latest foo
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/containerd", "--version"
  end
end
