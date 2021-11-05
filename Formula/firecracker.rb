class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.25.1",
    revision: "f082a91c5351443c7b802e2a59bf7c1ef10e08a1"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git",
    branch: "main"

  livecheck do
    url :stable
    regex(/^v(\d+\.\d+(\.\d+)?)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.25.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8663d28b3260e457b0a3d0db3865b80c7b17f21d87e86d4472ad75793898aa78"
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
