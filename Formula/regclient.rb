class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.9",
    revision: "0cb9b4c8bc5394be47432b3c884ff7933d40d0b8"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.9"
    sha256 cellar: :any_skip_relocation, catalina:     "943f603cff849eee734de993859cc41efb886117b097ad584fcd52c72b3b30b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45ed17665bd48ae474feffac9dfaca062e066ac78ee06aaf15532479d0a39e06"
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
