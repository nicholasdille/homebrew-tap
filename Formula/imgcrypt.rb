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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/imgcrypt-1.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "0eed0853a8fa0c42ac4299c85480126b0b66392f142f54e3922510b28b028f75"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "75db6ebe3bd4c7804f662e53aaba60fa7117dc5504bc2fc72e63ca89317d31ca"
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
