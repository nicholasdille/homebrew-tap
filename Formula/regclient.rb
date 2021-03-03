class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.2.1",
    revision: "4c6dd972a3c609f7c0997bb6e464aee431f8c971"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.2.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ff71cefa23107ea8936be2a218159a26af4ac48e739e08319f750eaf5fe5eeb"
  end

  depends_on "git" => :build
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
    system "#{bin}/regctl", "--help"
  end
end
