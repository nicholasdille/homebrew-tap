class Quark < Formula
  desc "Secure container runtime with OCI interface"
  homepage "https://github.com/QuarkContainer/Quark"

  url "https://github.com/QuarkContainer/Quark.git",
    revision: "2021648c1cdf5b35a9812583cba06ada180f3032"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/QuarkContainer/Quark.git"

  depends_on "make" => :build
  depends_on "rust" => :build
  depends_on :linux

  def install
    system "make", "release"
    bin.install "build/qkernel.bin"
    bin.install "target/release/quark"
    bin.install "vdso/vdso.so"
  end

  def post_install
    (etc/"quark").install "config.json"
  end

  test do
    system bin/"qvisor", "--help"
  end
end
