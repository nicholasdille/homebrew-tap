class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.32",
    revision: "436b460d1586c2e4ab4e845448449ddd9136767a"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.0.32"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d5da498401376237e31f667d2eb57bba92b87c1f1eb7ef03f70dbc7c96d47921"
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
