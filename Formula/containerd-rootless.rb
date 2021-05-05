class ContainerdRootless < Formula
  desc "Open and reliable container runtime"
  homepage "https://containerd.io"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.8.1",
    revision: "e1601447477c38ceb46c9c88418af399f79b1d6a"
  license "Apache-2.0"
  head "https://github.com/containerd/containerd.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containerd-rootless-0.8.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4554dc2aff915423ab06e54b885d9cf0c7403227535945b43cf0cc45dc6fe382"
  end

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
    system "#{HOMEBREW_PREFIX}/bin/containerd", "--version"
  end
end
