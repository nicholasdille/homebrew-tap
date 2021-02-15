class Buildkit < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.8.1",
    revision: "8142d66b5ebde79846b869fba30d9d30633e74aa"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git"

  depends_on "go" => :build

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

  test do
    system "#{bin}/buildkitd", "--version"
  end
end
