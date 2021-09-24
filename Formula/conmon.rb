class Conmon < Formula
  desc "OCI container runtime monitor"
  homepage "https://github.com/containers/conmon"

  url "https://github.com/containers/conmon.git",
    tag:      "v2.0.30",
    revision: "2792c16f4436f1887a7070d9ad99d9c29742f38a"
  license "Apache-2.0"
  head "https://github.com/containers/conmon.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/conmon-2.0.29"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e4907389b50abcade62fab262ba8b2a556ada32649569e943134f0020888c04"
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
