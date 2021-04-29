class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.3.2",
    revision: "4b6a2716227ba8562d119e25a25fca74fb4c12ae"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.3.0_1"
    sha256 cellar: :any_skip_relocation, catalina:     "7bbc20372af5b878266980d4dbf385a9441ce9a74dd0d892a9917a7a546970d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8cee02bd8c9bb09e52a8cdac87ceff4375cc46717b16983e2501ebb74b3ebb8e"
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
