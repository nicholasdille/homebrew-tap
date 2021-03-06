class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/AkihiroSuda/nerdctl"

  url "https://github.com/AkihiroSuda/nerdctl.git",
    tag:      "v0.6.1",
    revision: "7399297823f1d5745929d1e458c9da0d49c9e079"
  license "Apache-2.0"
  revision 1
  head "https://github.com/AkihiroSuda/nerdctl.git"

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/containerd-rootless"
  depends_on "nicholasdille/tap/buildkitd-rootless" => :recommended
  depends_on "nicholasdille/tap/cni" => :recommended
  depends_on "nicholasdille/tap/cni-isolation" => :recommended

  def install
    system "make"

    bin.install "_output/nerdctl"

    (buildpath/"nerdctl-rootless").write <<~EOS
      #!/bin/bash

      export XDG_RUNTIME_DIR=#{var}/run/containerd
      export CNI_PATH=#{prefix}/bin
      export NETCONFPATH=#{etc}/cni/net.d

      #{prefix}/bin/nerdctl "$@"
    EOS
    (etc/"docker").install "nerdctl-rootless"
  end

  def post_install
    (var/"lib/nerdctl").mkpath
  end

  def caveats
    <<~EOS
      TODO: brew immortal
      TODO: XDG_RUNTIME_DIR=#{var}/run/containerd
      TODO: CNI_PATH=#{prefix}/bin
      TODO: NETCONFPATH=#{etc}/cni/net.d
      TODO: nerdctl.sh
    EOS
  end

  test do
    ENV["XDG_RUNTIME_DIR"] = var/"lib/nerdctl"
    system "#{bin}/nerdctl", "--version"
  end
end
