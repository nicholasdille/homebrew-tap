class Regclient < Formula
  desc "Docker and OCI Registry Client in Go and regctl command-line"
  homepage "https://github.com/regclient/regclient"

  url "https://github.com/regclient/regclient.git",
    tag:      "v0.4.3",
    revision: "b0ac3e9413b1079c8b14df5c201a2a2129d9d9e1"
  license "Apache-2.0"
  head "https://github.com/regclient/regclient.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/regclient-0.4.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "1fc5fc70d295fb5840db5fe607137eaccaac3694a1f9a836d405ce21ebe0224e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d20ca47a403ef772c62be755067ef49732f0db8560d2361fb66d15849ed66dc2"
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
