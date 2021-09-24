class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.4.1",
    revision: "d5ec175475d8b07b01986640e4f5b5fc827526cb"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.4.1"
    sha256 cellar: :any_skip_relocation, catalina:     "a9006a8e141c189ef67e970f365f73f45768082386c82339d5e08e01ed00f897"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41215adbe471b4151e641ee405b72309c17c658c0cf9b344b95de65b74bc3352"
  end

  depends_on "go" => :build
  depends_on arch: :x86_64

  def install
    os = "linux"  if OS.linux?
    os = "darwin" if OS.mac?
    arch = "amd64"

    ENV["VCLUSTER_BUILD_PLATFORMS"] = os
    ENV["VCLUSTER_BUILD_ARCHS"] = arch
    name = "vcluster-#{os}-#{arch}"

    system "bash", "./hack/build-cli.sh"
    bin.install "release/#{name}" => "vcluster"
  end

  test do
    system bin/"vcluster", "--help"
  end
end
