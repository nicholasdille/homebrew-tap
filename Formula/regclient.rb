class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.3",
    revision: "61a71d4fb8fcb87f76f606095ca648e68eeeedfc"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.3"
    sha256 cellar: :any_skip_relocation, catalina:     "e46a7faa54a456114eb126eb62d812ca7160f7927767d669279d5b5172a22fe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cd64949e6be644dfe4333a85b1834f6364d8a2d857bc3794c58fc8b4d1f5e4d2"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make"
    bin.install "bin/regctl"
    bin.install "bin/regsync"
    bin.install "bin/regbot"
    bin.install "docker-plugin/docker-regclient"
  end

  test do
    system bin/"regctl", "version"
  end
end
