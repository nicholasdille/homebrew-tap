class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.1.0",
    revision: "58b1dd1b8c8e9920e6fe3d4e117f0a2b76ab952c"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.1.0"
    sha256 cellar: :any_skip_relocation, catalina:     "11552f5eb7ff641b41fb755673abb8a26ba68ac63d31183571eb05bb99cf4678"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be552b82a94a216c61e21939a34f77a08d3d704b61992923be4818ea69ad9350"
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
