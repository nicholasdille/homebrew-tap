class ContainerdRootless < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.6.1",
    revision: "7399297823f1d5745929d1e458c9da0d49c9e079"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  depends_on "immortal"
  depends_on "nicholasdille/tap/containerd"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  def install
    bin.install "extras/rootless/containerd-rootless.sh"

    (buildpath/"containerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/containerd-rootless.sh
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

  def post_install
    (var/"run/containerd").mkpath
    (var/"log").mkpath
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
    system "#{HOMEBREW_PREFIX}/bin", "--version"
  end
end
