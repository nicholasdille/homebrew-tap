class Sysbox < Formula
  desc "Enables containers to act as virtual servers"
  homepage "https://www.nestybox.com/"

  url "https://github.com/nestybox/sysbox.git",
    tag:      "v0.2.1",
    revision: "2ed540ae54e4f8fd9fff8655037de5edd38a4a56"
  license "Apache-2.0"
  head "https://github.com/nestybox/sysbox.git"

  depends_on "make" => :build

  def install
    system "make", "sysbox"
    system "make", "install", "INSTALL_DIR=#{prefix}"
  end

  test do
    system "sysbox", "--version"
  end
end
