class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
  tag:      "release-20211019.0",
  revision: "03bc93d2b82045fc44102d0f40a208f97db16479"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  def install
    system "make", "runsc"
    bin.install "bazel-bin/runsc/linux_amd64_pure_stripped/runsc"
  end

  test do
    system "#{bin}/runsc", "--version"
  end
end
