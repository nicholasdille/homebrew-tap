class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20210614.0",
    revision: "3cf1644a3b4266979b7dda8b6291edf19264fa19"
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
