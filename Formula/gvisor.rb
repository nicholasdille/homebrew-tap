class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220314.0",
    revision: "ee133dbcf204c8518d9b272d2f91977f3ee1971c"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/gvisor-20220309.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0bfca4985e7a75454192521b0f2d5e3e0d328cf6daba27c59ee6a578223d811b"
  end

  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  resource "runsc" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220124/x86_64/runsc"
    sha256 "ac06e0d08f5e85d26967d10052464b14f8df7818d84ae5552bc82bb630d1cb2b"
  end

  resource "containerd-shim-runsc-v1" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220124/x86_64/containerd-shim-runsc-v1"
    sha256 "da06821a412954892eebf3f5259e4a85475dfb94dad3de35e27b8818165dc97e"
  end

  def install
    resource("runsc").stage do
      bin.install "runsc"
    end
    resource("containerd-shim-runsc-v1").stage do
      bin.install "containerd-shim-runsc-v1"
    end
  end

  test do
    system "#{bin}/runsc", "--version"
  end
end
