class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v1.1.1",
    revision: "1285e4a356c61c7a8455dee4273df77bd05d0c16"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git",
    branch: "main"

  livecheck do
    url :stable
    regex(/^v(\d+\.\d+(\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-1.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b64447d37b4ad6bc57c5ade63502b2c61be5a66c3b3935ba5c080819f20ad2e3"
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
