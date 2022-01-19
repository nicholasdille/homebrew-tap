class Gvisor < Formula
  desc "Application Kernel for Containers"
  homepage "https://gvisor.dev/"

  url "https://github.com/google/gvisor.git",
    tag:      "release-20220117.0",
    revision: "b488df0a2f15ba21603610bdb13d8656b856218f"
  version "20220117.0"
  license "Apache-2.0"
  head "https://github.com/google/gvisor.git",
    branch: "master"

  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  resource "runsc" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220117/x86_64/runsc"
    sha256 "7c583955080698d097fad69f22cf56d642885e0242bc8b9cdc1ed2086301cd0b"
  end

  resource "containerd-shim-runsc-v1" do
    url "https://storage.googleapis.com/gvisor/releases/release/20220117/x86_64/containerd-shim-runsc-v1"
    sha256 "69cfcb049fe9fe3823c96a9672c4b77d63f3e274d50e18d662afbab234247762"
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
