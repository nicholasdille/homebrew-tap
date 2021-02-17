class BuildkitBin < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit/releases/download/v0.8.1/buildkit-v0.8.1.linux-amd64.tar.gz"
  version "0.8.1"
  sha256 "e0438a701d4192f80b2211b0a333984ee4f097c547904e40fc941daad57fe153"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "immortal"
  depends_on "nicholasdille/tap/rootlesskit-bin"
  depends_on "nicholasdille/tap/slirp4netns-bin"

  resource "buildctl-daemonless.sh" do
    url "https://github.com/moby/buildkit/raw/v0.8.1/examples/buildctl-daemonless/buildctl-daemonless.sh"
    sha256 "cb2f6c3bcb275cb271b54214484d07b6032a88c720e4dfc197773754425afda7"
  end

  def install
    bin.install "buildctl"
    bin.install "buildkit-qemu-aarch64"
    bin.install "buildkit-qemu-arm"
    bin.install "buildkit-qemu-ppc64le"
    bin.install "buildkit-qemu-riscv64"
    bin.install "buildkit-qemu-s390x"
    bin.install "buildkit-runc"
    bin.install "buildkitd"

    resource("buildctl-daemonless.sh").stage do
      bin.install "buildctl-daemonless.sh"
    end

    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: #{bin}/rootlesskit --net=slirp4netns --copy-up=/etc --disable-host-loopback #{bin}/buildkitd
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
