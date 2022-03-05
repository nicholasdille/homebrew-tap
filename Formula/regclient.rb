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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.10"
    sha256 cellar: :any_skip_relocation, big_sur:      "716e2c722184398ec33152effcb6cf58f038cee166700512cb40d7a5a08f8aa1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b934e4102a95780817ddfec214163084f81dd84d931a38909b0ac63959eff930"
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
