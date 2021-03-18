class Quark < Formula
  desc "Secure container runtime with OCI interface"
  homepage "https://github.com/QuarkContainer/Quark"

  url "https://github.com/QuarkContainer/Quark/archive/main.zip"
  sha256 "5e90837a3d2f41bad0243d6a3410a7b85f9664a0fe768a2edde547e6db0c1bc9"
  version "main"
  license "Apache-2.0"
  head "https://github.com/QuarkContainer/Quark.git"

  depends_on "rust" => :build
  depends_on "make" => :build

  def install
    system "make", "release"
  end

  test do
    #
  end
end
