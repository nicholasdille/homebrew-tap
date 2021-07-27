class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.3.3",
    revision: "3c76dfadb03845a9ef9b2fcaec2fa1f2a80d5468"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.3.3"
    sha256 cellar: :any_skip_relocation, catalina:     "35a22f842cbc001eaa0f6f20322165edccfd94161c833d274c891c2f3013ed41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7a70e41c45099f2c6824ccf339bd7e91ef58c2f6bbd4dbe18aeaf34561be5bdb"
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
