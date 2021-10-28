class Cado < Formula
  desc "Capability DO like sudo"
  homepage "https://github.com/rd235/cado"

  url "https://github.com/rd235/cado.git",
    tag:      "v0.9.5",
    revision: "942ec59c61ffe81a2a80e93eaa8e2a3d86565042"
  license "GPL-2.0-only"
  head "https://github.com/rd235/cado.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cado-0.9.5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2cc57c0fdfe3de0cc3a548c6848eb77597c0be9d8d6bc25085903c305f51903e"
  end

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "nicholasdille/tap/libexecs" => :build
  depends_on "pkg-config" => :build
  depends_on "libcap"
  depends_on :linux
  depends_on "linux-pam"
  depends_on "mhash"

  def install
    mkdir buildpath/"build"
    cd buildpath/"build" do
      system "cmake", "..", "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"
      system "make"
      system "make", "install"
    end
  end

  def caveats
    <<~EOS
      cado requires root access as well as /etc/cado.conf. See "man cado.conf".
    EOS
  end

  test do
    system "whereis", "cado"
  end
end
