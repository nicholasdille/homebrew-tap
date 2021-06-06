class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.24.4",
    revision: "8f44986a0e956a77f2b2324c12f73bec16130c82"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.24.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5b5a03a6be14af6bb6f79538f2e71e2e0ddfbd5ea2e2a856b370ecbac3c853f0"
  end

  depends_on arch: :x86_64
  depends_on :linux

  def install
    system "tools/devtool", "-y", "build", "--release"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/firecracker"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/jailer"
  end

  test do
    system bin/"firecracker", "--version"
  end
end
