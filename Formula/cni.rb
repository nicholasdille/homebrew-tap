class Cni < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins.git",
    tag:      "v1.1.1",
    revision: "4744ec27b89c083194e7df498de50f03a8a1d3ec"
  license "Apache-2.0"
  head "https://github.com/containernetworking/plugins.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-1.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8dc998001e918410f6e2550e0ef6903e7b4fa8f72e896270f80a4d05bb92902"
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
