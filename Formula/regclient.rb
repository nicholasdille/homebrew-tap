class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.4.4",
    revision: "333c44dcfc3b062776ef70a9264ff30914d4770e"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.4.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "4db7f30c65ff916499942a4d7ef2d0f1fe594095655dda5d0bf28cfc71ee9701"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f85dfa4cc46b59e13920f2ef7a487a2932d0627050f9602e0c10e08bebc84ad"
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
