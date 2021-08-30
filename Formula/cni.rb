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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cni-1.0.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d07b5e0a891231b1b069636630a75d47509fd39f6b1b277a4090daaaa1f77bec"
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
