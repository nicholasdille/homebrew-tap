class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.24.5",
    revision: "cd36c699f3cb3d531289aadee26c45c1306edcfc"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.24.5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "72cc4af216ac79ce17b7688798b84670066d4a834eca9634cde46ced60e4dbeb"
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
