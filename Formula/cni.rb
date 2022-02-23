class Cni < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins.git",
    tag:      "v1.1.0",
    revision: "26745d375201a7e4851d2eb40aa6f2bb2bc0bb61"
  license "Apache-2.0"
  head "https://github.com/containernetworking/plugins.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-1.0.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9088348d8935c61dfa672269839d369ceb1517d366f44a6b2330f9d15ddde2c0"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    system "./build_linux.sh"
    bin.install (buildpath/"bin").children
  end

  test do
    system bin/"loopback"
  end
end
