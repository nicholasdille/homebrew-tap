class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.6.0",
    revision: "a24df2aad83851065acc967485a879f91083a8bb"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.5.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "02db51a03a13d2c7506aef1b8b05b8df4efc0af3cdcc4e5dbfbf05ad6cd5598a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc03f47fc94b3fb13d480d150972fd8102580a3295c85d16048d451b4ed6ecee"
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
