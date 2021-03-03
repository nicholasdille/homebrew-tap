class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.23.3",
    revision: "70076e111b687610c687fbb0b80d101de6fc57b7"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git"

  def install
    system "tools/devtool", "-y", "build", "--release"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/firecracker"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/jailer"
  end

  test do
    system "#{bin}/firecracker", "--version"
  end
end
