class Imgcrypt < Formula
  desc "OCI Image Encryption Package"
  homepage "https://github.com/containerd/imgcrypt"

  url "https://github.com/containerd/imgcrypt.git",
    tag:      "v1.1.1",
    revision: "f385f6ca972ac8169ce321830911d0253cb0b194"
  license "Apache-2.0"
  head "https://github.com/containerd/imgcrypt.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    system bin/"ctd-decoder", "--help"
  end
end
