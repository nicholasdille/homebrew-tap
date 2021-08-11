class Cni < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins.git",
    tag:      "v1.0.0",
    revision: "8632ace977f4126c8ded601975f564571c66b922"
  license "Apache-2.0"
  head "https://github.com/containernetworking/plugins.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-0.9.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "16a340804a930e6f2783b18a1842629cab3d2de8424e5afb8c6da1885b9d7faf"
  end

  depends_on "go" => :build

  def install
    system "./build_linux.sh"
    bin.install (buildpath/"bin").children
  end

  test do
    system bin/"loopback"
  end
end
