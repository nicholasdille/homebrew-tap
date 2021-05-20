class NerdctlImmortal < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.8.2",
    revision: "9d371e95e60634f8c4bc7e06f7e1945366d52159"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-immortal-0.8.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a3d6b51551b41f0ede8c6feb50c3a793c04dfd00d129141beb90a6746baea566"
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
    (etc/"immortal").install "nerdctl-containerd.yml"

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
    (etc/"immortal").install "nerdctl-buildkitd.yml" if build.with? "buildkitd-rootless"
  end

  def post_install
    (var/"run/nerdctl-containerd").mkpath
    (var/"run/nerdctl-buildkitd").mkpath if build.with? "buildkitd-rootless"
    (var/"log").mkpath
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
