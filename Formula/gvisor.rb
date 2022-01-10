class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220103.0",
    revision: "b488df0a2f15ba21603610bdb13d8656b856218f"
  license "Apache-2.0"
  version "20220103.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  resource "runsc" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220103.0/x86_64/runsc"
    sha256 "6be7e228dbb1a9e8bb1c443183de9f2910ceb3aeb67c93d1d899358b117d9b5e"
  end

  resource "containerd-shim-runsc-v1" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220103.0/x86_64/containerd-shim-runsc-v1"
    sha256 "797e10587af1fdca4dc3d00577bd9a90a91a5e88c7d1e9b3eadad7335ab032c8"
  end

  def install
    resource("runsc").stage do |resource|
      bin.install "runsc"
    end
    resource("containerd-shim-runsc-v1").stage do |resource|
      bin.install "containerd-shim-runsc-v1"
    end
  end

  test do
    system "#{bin}/runsc", "--version"
  end
end
