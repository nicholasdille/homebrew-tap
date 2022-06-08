class Imgcrypt < Formula
  desc "OCI Image Encryption Package"
  homepage "https://github.com/containerd/imgcrypt"

  url "https://github.com/containerd/imgcrypt.git",
    tag:      "v1.1.6",
    revision: "23f077229f2cdee91ba70d49684751187a5775f5"
  license "Apache-2.0"
  head "https://github.com/containerd/imgcrypt.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgcrypt-1.1.6"
    sha256 cellar: :any_skip_relocation, big_sur:      "1137bc04e7d4c96c73fac5fff4b2bfa1e41011159d48bedb8e0d5933bea6dd09"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "269566f2dac6177fe4cad62ee97c754cfc38c4b3dd091b9b132a0f6a1484a1c1"
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
