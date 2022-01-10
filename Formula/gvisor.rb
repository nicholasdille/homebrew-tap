class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220103.0",
    revision: "b488df0a2f15ba21603610bdb13d8656b856218f"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  depends_on "bazel" => :build
  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  def install
    system "bazel", "build", "//runsc", "--sandbox_debug"
    puts Utils.safe_popen_read("find", ".", "-type", "f", "-name", "runsc")
    # bin.install "bazel-bin/runsc/linux_amd64_pure_stripped/runsc"
  end

  test do
    system "#{bin}/runsc", "--version"
  end
end
