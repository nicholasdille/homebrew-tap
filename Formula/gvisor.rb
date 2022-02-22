class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220222.0",
    revision: "6e5b602ee1a1e48349f7ed01958ed1aa0cacdba3"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/gvisor-20220222.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3af30b77815b2cef6f3f8063ede97285fbb2d084e1e52dc447791846b00e3954"
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
