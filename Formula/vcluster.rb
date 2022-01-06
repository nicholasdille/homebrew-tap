class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.5.1",
    revision: "dab04030fb55d178d3aa9dc65d486bb661536109"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "bc0331f6c6dd8730fdf2069d8ab74472dc72afa7036e852c8cb3d068bd08258a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "55024d692cb438119c0bce810154a81b38d9d48da8518b88dff7db9bc897cc61"
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
