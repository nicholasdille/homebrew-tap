class Cni < Formula
  desc "Some reference and example networking plugins, maintained by the CNI team"
  homepage "https://github.com/containernetworking/plugins"

  url "https://github.com/containernetworking/plugins.git",
    tag:      "v1.0.1",
    revision: "189d0c06aa6da0c4f052d3831b091e6ea79e6675"
  license "Apache-2.0"
  head "https://github.com/containernetworking/plugins.git",
    branch: "master"

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
