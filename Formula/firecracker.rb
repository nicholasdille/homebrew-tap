class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.25.0",
    revision: "f824c2f42638da9ccad259eb8c6a7021e2a304a0"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git",
    branch: "main"

  livecheck do
    url :stable
    regex(/^v(\d+\.\d+(\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.25.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3667fbf4ccb8bf624a6d8c87c804ad0c7046293eb07eb61464727d69fa4ec28c"
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
