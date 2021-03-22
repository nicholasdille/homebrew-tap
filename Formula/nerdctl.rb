class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.7.1",
    revision: "bfc14c75f401a5f39d50d93b0c6a461d0cc46358"
  license "Apache-2.0"
  revision 1
  head "https://github.com/containerd/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.7.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fdf77d67f60271d6281150c33353f579972e3a365efaec4586ebd6150ef97498"
  end

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

    # bash completion
    output = Utils.safe_popen_read(bin/"nerdctl", "completion", "bash")
    (bash_completion/"nerdctl").write output

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
    system bin/"nerdctl", "--version"
  end
end
