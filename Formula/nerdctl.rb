class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd"
  homepage "https://github.com/containerd/nerdctl"

  url "https://github.com/containerd/nerdctl.git",
    tag:      "v0.7.3",
    revision: "77801f5042e05ed3cac52efbeb18aafc09795675"
  license "Apache-2.0"
  head "https://github.com/containerd/nerdctl.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/nerdctl-0.7.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2700ed1a9d00257e03402db71fb2b843dbbfcf62b823b2f8b3383f1d9e97fa7"
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
    ENV["XDG_RUNTIME_DIR"] = "/tmp"
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
    (var/"run/nerdctl").mkpath
  end

  def caveats
    <<~EOS
      TODO: Set XDG_RUNTIME_DIR
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
