class NerdctlImmortal < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.21.0",
    revision: "9ddf5226eabcbb7b4b43987f3b0f8d53d86d3bca"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-immortal-0.20.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "37ce0c50c41801121e885754c94c17a1c88b723e36356bef46f2416e497edd75"
  end

  depends_on "immortal"
  depends_on "nicholasdille/tap/cni-isolation"
  depends_on "nicholasdille/tap/containerd-rootless"
  depends_on "nicholasdille/tap/nerdctl"
  depends_on "nicholasdille/tap/buildkitd-rootless" => :recommended

  def install
    bin.install "extras/rootless/containerd-rootless-setuptool.sh"

    (buildpath/"nerdctl-rootless").write <<~EOS
      #!/bin/bash

      export XDG_RUNTIME_DIR=#{var}/run/nerdctl-containerd
      export CNI_PATH=#{HOMEBREW_PREFIX}/bin
      export NETCONFPATH=#{etc}/cni/net.d

      #{HOMEBREW_PREFIX}/bin/nerdctl "$@"
    EOS
    bin.install "nerdctl-rootless"

    (buildpath/"nerdctl-containerd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/containerd-rootless.sh
      env:
        XDG_RUNTIME_DIR: #{var}/run/nerdctl-containerd
        XDG_DATA_HOME: #{var}/lib/nerdctl-containerd
        XDG_CONFIG_HOME: #{etc}/nerdctl-containerd
      pid:
        parent: #{var}/run/nerdctl-containerd/parent.pid
        child: #{var}/run/nerdctl-containerd/child.pid
      log:
        file: #{var}/log/nerdctl-containerd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    pkgshare.install "nerdctl-containerd.yml"

    (buildpath/"nerdctl-buildkitd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/containerd-rootless-setuptool.sh nsenter #{HOMEBREW_PREFIX}/buildkitd
      env:
        XDG_RUNTIME_DIR: #{var}/run/nerdctl-buildkitd
      pid:
        parent: #{var}/run/nerdctl-buildkitd/parent.pid
        child: #{var}/run/nerdctl-buildkitd/child.pid
      log:
        file: #{var}/log/nerdctl-buildkitd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    pkgshare.install "nerdctl-buildkitd.yml"
  end

  def post_install
    mkdir_p etc/"immortal"
    cp pkgshare/"nerdctl-containerd.yml", etc/"immortal"
    cp pkgshare/"nerdctl-buildkitd.yml", etc/"immortal" if build.with? "buildkitd-rootless"
    mkdir_p var/"run/nerdctl-containerd"
    mkdir_p var/"run/nerdctl-buildkitd" if build.with? "buildkitd-rootless"
    mkdir_p var/"log"
  end

  def caveats
    <<~EOS
      - TODO: Options are rootless containerd or rootless for nerdctl
      - To work with nicholasdille/tap/containerd, set XDG_RUNTIME_DIR:
          export XDG_RUNTIME_DIR=#{var}/run/nerdctl-containerd
          export CNI_PATH=#{prefix}/bin
          export NETCONFPATH=#{etc}/cni/net.d
      - Alternatively use #{prefix}/nerdctl-rootless
      - You can now run rootless containerd and buildkitd using immortal
      - Consider using the external command "brew immortal" from nicholasdille/homebrew-immortal
      - To access containerd set CONTAINERD_ADDRESS:
          export CONTAINERD_ADDRESS=/home/linuxbrew/.linuxbrew/var/run/containerd/containerd.sock
      - Also set CONTAINERD_SNAPSHOTTER:
          export CONTAINERD_SNAPSHOTTER=native
      - Example use:
          ctr images pull docker.io/library/alpine:latest
          ctr run -t --rm --fifo-dir /tmp/foo-fifo --cgroup "" docker.io/library/alpine:latest foo
    EOS
  end

  test do
    system "#{HOMEBREW_PREFIX}/bin/containerd", "--version"
  end
end
