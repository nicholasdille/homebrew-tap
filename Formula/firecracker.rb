class Firecracker < Formula
  desc "Secure and fast microVMs for serverless computing"
  homepage "http://firecracker-microvm.io/"

  url "https://github.com/firecracker-microvm/firecracker.git",
    tag:      "v0.24.2",
    revision: "5ba819d7b7a684107f5434bcbd1617bc94565478"
  license "Apache-2.0"
  head "https://github.com/firecracker-microvm/firecracker.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/firecracker-0.24.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1bb709b79d7a461eb22937e254079727cd139bb21a19f6513d40d6e04e0836da"
  end

  def install
    system "tools/devtool", "-y", "build", "--release"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/firecracker"
    bin.install "build/cargo_target/x86_64-unknown-linux-musl/release/jailer"
  end

  test do
    system "#{bin}/firecracker", "--version"
  end
end
