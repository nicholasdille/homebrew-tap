class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.6",
    revision: "bb10367e976724baf717a7a43218ad4ccbbb1fbe"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.6"
    sha256 cellar: :any_skip_relocation, catalina:     "297a90f49e3d0a6067e036569913c9af66f70c9533b8b0b37f9abcc723c56790"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cbfb947dbefa6d506f54212ef5cabec5e2ee17bbbae5a0e1113b483e60533f85"
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
