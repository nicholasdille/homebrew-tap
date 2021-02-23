class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.8.1",
    revision: "8142d66b5ebde79846b869fba30d9d30633e74aa"
  license "Apache-2.0"
  revision 1
  head "https://github.com/moby/buildkit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkit-0.8.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "155e3f35fbe374a1486717b0ab7e93f911964a07f9ab98689d4fb38190efb8dd"
  end

  depends_on "go" => :build
  depends_on "immortal"
  depends_on "nicholasdille/tap/fuse-overlayfs-bin"
  depends_on "nicholasdille/tap/rootlesskit"
  depends_on "nicholasdille/tap/slirp4netns"

  conflicts_with "buildkit"

  def install
    system "make"

    bin.install "bin/buildctl"
    bin.install "bin/buildkit-qemu-aarch64"
    bin.install "bin/buildkit-qemu-arm"
    bin.install "bin/buildkit-qemu-ppc64le"
    bin.install "bin/buildkit-qemu-riscv64"
    bin.install "bin/buildkit-qemu-s390x"
    bin.install "bin/buildkit-runc"
    bin.install "bin/buildkitd"

    (var/"run/buildkitd").mkpath
    (var/"log").mkpath
    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/rootlesskit --net=slirp4netns --copy-up=/etc --disable-host-loopback #{HOMEBREW_PREFIX}/bin/buildkitd
      env:
        XDG_RUNTIME_DIR: #{var}/run/buildkitd
      pid:
        parent: #{var}/run/buildkitd/parent.pid
        child: #{var}/run/buildkitd/child.pid
      log:
        file: #{var}/log/buildkitd.log
        age: 86400
        num: 7
        size: 1
        timestamp: true
    EOS
    (etc/"immortal").install "buildkitd.yml"
  end

  test do
    system "#{bin}/buildkitd", "--version"
  end
end
