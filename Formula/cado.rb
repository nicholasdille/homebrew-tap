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

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "mhash" => :build
  depends_on "nicholasdille/tap/libexecs" => :build
  depends_on "pkg-config" => :build

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
