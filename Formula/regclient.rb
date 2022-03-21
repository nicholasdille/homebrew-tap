class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.4.1",
    revision: "4442cd773c348d7d5e6bd2b9a0cb58e2bce81d67"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "13b1aaea2f27eff95ae05c15daed9ec6a2eda0369ebde75cb646d7e3eb549cad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5510407ffd887f61927349fd0b32d733364caf2f1b36d3077156345fda0339eb"
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
