class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.4.2",
    revision: "95b0bd5d18de169fc59a0a2bf44609954f4e404a"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.4.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "1d845b987eb58d2aed7779e8ef7c0d749cb8af66cb4f988d15b33e23080b33c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2c2ce4a849a8e524f7275cc5fd0d232053b81e1eaf1cd6619d5deab62a0eb712"
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
