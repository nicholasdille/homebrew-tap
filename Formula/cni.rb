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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-1.1.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4eb859bdb443db8b262d939e74fb46c9f92a5c1253b94d057690a88b41c77ca0"
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
