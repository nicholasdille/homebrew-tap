class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.31",
    revision: "7e7eb74e52abf65a6d46807eeaea75425cc8a36c"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.0.31"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f9458e9e3931acd4ed896c9f0de61556dc8d2d941ba4ac84c663630c8d0ab910"
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
