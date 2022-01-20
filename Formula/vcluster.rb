class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.5.3",
    revision: "e86061ec411aecb034fb2350b92ed6d283d00e86"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.5.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "0d0460cc0b9e94978b8c7be78a04cdeaaffd9e6e46be35bd8e22bc7845de748d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aa40e7221c5a586e6abe75d4b472b174ae42d6353e3097312a7ed6ca3d431d91"
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
