class ContainerdRootless < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.8.2",
    revision: "9d371e95e60634f8c4bc7e06f7e1945366d52159"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-rootless-0.8.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b4395aa80c54bd0a66d4da14751af181739fc2e1ca1cd2e4b9225a804114f7aa"
  end

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    bin.install "extras/rootless/containerd-rootless.sh"

    (buildpath/"containerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/containerd-rootless.sh --config #{etc}/containerd/config.toml
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
    (etc/"containerd").install "config.toml"
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
          $ nsenter -U --preserve-credentials -m -n -t $(cat #{var}/run/containerd/containerd-rootless/child_pid)
          $ export CONTAINERD_ADDRESS=#{var}/run/containerd/containerd.sock
          $ export CONTAINERD_SNAPSHOTTER=native
          $ ctr images pull docker.io/library/alpine:latest
          $ ctr run -t --rm --fifo-dir /tmp/foo-fifo --cgroup "" docker.io/library/alpine:latest foo
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/containerd", "--version"
  end
end
