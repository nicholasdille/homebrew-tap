class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.1.1",
    revision: "65b6eaaf91ed8fd4ef0d5cd9038cff72667cc6be"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "89427180b161f1d36dc03e34d36ce0b4524f8276e3a12bb1ff3c91afa0de3130"
  end

  depends_on "go-md2man" => :build
  depends_on "libseccomp" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on :linux
  depends_on "systemd"

  def install
    system "make", "bin/conmon"
    bin.install "bin/conmon"

    system "make", "-C", "docs", "GOMD2MAN=go-md2man"
    man8.install Dir["docs/*.8"]
  end

  test do
    system "#{bin}/conmon", "--version"
  end
end
