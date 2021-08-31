class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20210823.0",
    revision: "0a15a216daab9523a5f0c7b93bbceae98dbcbcc1"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/cni"

  def install
    system "make", "runsc", "OPTIONS=--verbose_failures"

    bin.install "bazel-out/k8-opt-ST-4c64f0b3d5c7/bin/runsc/runsc_/runsc"
  end

  test do
    system "#{bin}/runsc", "--version"
  end
end
