class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.0",
    revision: "5a6a1d95524b9c1c2d38a5af7ab744742f8d55e9"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "27bb2be30e54081c7ddb4db35d14febd8e3140610859b7a35e834eab1651384e"
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
    system bin/"regctl", "--help"
  end
end
