class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.3.0",
    revision: "e0115dd6b30dc0bb356f2e597e216fda285d5290"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "84495f8df70fe091d06ddc022eeb153f622bd309afe65627e79edc526524d6cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c3892c05007997862c3c5c0efed55f5a0e5fdaa34eb9799ae421912530283cc1"
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
