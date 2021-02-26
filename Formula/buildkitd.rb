class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.8.2",
    revision: "9065b18ba4633c75862befca8188de4338d9f94a"
  license "Apache-2.0"
  revision 1
  head "https://github.com/moby/buildkit.git"

  depends_on "go" => :build
  depends_on "make" => :build

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
  end

  def caveats
    <<~EOS
      TODO: brew immortal
      TODO: export BUILDKIT_HOST
    EOS
  end

  test do
    system "#{bin}/buildkitd", "--version"
  end
end
