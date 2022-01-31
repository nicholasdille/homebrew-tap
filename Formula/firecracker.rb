class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v1.0.0",
    revision: "d3e98b9a4ae024de63f072c57015d8b7b0c1b061"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git",
    branch: "main"

  livecheck do
    url :stable
    regex(/^v(\d+\.\d+(\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.25.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9354d299aeaf8a3868a914204c089367a7aa7a7b055c84b9a6245201c9f16c4f"
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
