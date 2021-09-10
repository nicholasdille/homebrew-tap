class SuExec < Formula
  desc "Switch user and group id and exec"
  homepage "https://github.com/ncopa/su-exec/"

  url "https://github.com/ncopa/su-exec.git",
    tag:      "v0.2",
    revision: "f85e5bde1afef399021fbc2a99c837cf851ceafa"
  license "MIT"
  head "https://github.com/ncopa/su-exec.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "make", "su-exec-static"
    bin.install "su-exec-static" => "su-exec"
  end

  test do
    system bin/"su-exec", "--help"
  end
end
