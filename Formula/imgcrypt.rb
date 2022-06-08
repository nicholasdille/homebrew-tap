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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgcrypt-1.1.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "2c7726bb2ac0928d66383d19e60f412704d68a77f18e55f64db77b2317216622"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "00957800fb608a614d59059616b73780654c7d6008d623f3d2d33f3515aa230a"
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
