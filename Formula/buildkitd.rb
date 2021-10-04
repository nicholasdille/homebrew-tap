class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.9.1",
    revision: "966bcf4aa3ef397a9d6025fade18f2d59a5bf29d"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git",
    branch: "master"

  livecheck do
    url :stable
    regex(/^v(.+)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-0.9.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "098c4990dba193608d69a762e2bf53a194263a4480b80f74f8f8f4c402027782"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux

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

    (buildpath/"buildkitd.yml").write <<~EOS
      cmd: #{HOMEBREW_PREFIX}/bin/buildkitd
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
    system bin/"buildkitd", "--version"
  end
end
