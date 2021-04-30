class Buildkitd < Formula
  desc "Concurrent, cache-efficient, and Dockerfile-agnostic builder toolkit"
  homepage "https://github.com/moby/moby/issues/34227"

  url "https://github.com/moby/buildkit.git",
    tag:      "v0.8.3",
    revision: "81c2cbd8a418918d62b71e347a00034189eea455"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-0.8.2_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4e08dc487351284f2e1e7fd5869109e6aa0a086b9847431d1edd8867f386f1e5"
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
  end

  test do
    system bin/"buildkitd", "--version"
  end
end
