class Imgcrypt < Formula
  desc "OCI Image Encryption Package"
  homepage "https://github.com/containerd/imgcrypt"

  url "https://github.com/containerd/imgcrypt.git",
    tag:      "v1.1.3",
    revision: "65d749cef36547473d1c1b0b67ed8a4b9e3d13d4"
  license "Apache-2.0"
  head "https://github.com/containerd/imgcrypt.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgcrypt-1.1.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "4d3d3ec1e38ba5143e9386442e224a430384d6b8c85f7db2622ac4b4f7575fd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8f57685ac8cfd9a1f82ac2f0e4bb936f661b47150056f773f3142a32c98e420d"
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
