class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.24.4",
    revision: "8f44986a0e956a77f2b2324c12f73bec16130c82"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.24.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "307b5475e9a497ddcf8999c8c478b09c699e2371dcbc3d6a4b92a7f3e2066b61"
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
