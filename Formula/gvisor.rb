class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220131.0",
    revision: "2a3d59997fb9731bae6f0dd3b23d4b17455fed29"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/gvisor-20220131.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f054f682295fed4520e2f215871cebdbe0f7dc4a83e904b876f97185ea6477c2"
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
