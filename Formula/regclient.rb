class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.4.0",
    revision: "9546658ede6901191b9692a7f720c37150940ddd"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "75a8c9a2922950c3097a35c81f7ecec819dd3f49b874ffd5677962aaee6aedb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "98606bc115d80701a44d08976563a2d5286a48c001d8b1d4e92dfb119c3ba53b"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "binaries"
    bin.install "bin/regctl"
    bin.install "bin/regsync"
    bin.install "bin/regbot"
    bin.install "docker-plugin/docker-regclient"
  end

  test do
    system bin/"regctl", "version"
  end
end
