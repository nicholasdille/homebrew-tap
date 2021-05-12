class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.2.0",
    revision: "2d995a042e2f008f2c46c686e6c7f1d6eab1a9bb"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "0f2b40941c4f211ed16dbd98ee5184dc0dc615b4f201d562c9c0dc979a8c9613"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0ce719b6315f2a32a4cdbaeb95678ed6512de5039f59e4073d620f03d295d6d"
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
