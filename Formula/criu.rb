class Criu < Formula
  desc "Checkpoint/Restore tool"
  homepage "https://criu.org/"

  url "https://github.com/checkpoint-restore/criu.git",
    tag:      "v3.15",
    revision: "f68da4a86fee62af216e9e7520f4916aa29e797b"
  license ""
  head "https://github.com/checkpoint-restore/criu.git"

  depends_on "asciidoc" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "libnet" => :build
  depends_on "pkg-config" => :build
  depends_on "protobuf-c" => :build
  depends_on "xmlto" => :build
  depends_on :linux

  def install
    ln_sf "#{HOMEBREW_PREFIX}/include/google/protobuf/descriptor.proto",
          "#{buildpath}/images/google/protobuf/"
    system "make", "install", "PREFIX=#{prefix}", "USE_ASCIIDOCTOR=1"
  end

  test do
    system bin/"criu", "--version"
  end
end
