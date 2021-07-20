class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.3.2",
    revision: "5cfa39fd73140a8aec32696b2b7972f9a2b08d68"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.3.1"
    sha256 cellar: :any_skip_relocation, catalina:     "f17c502c9de021c77b0584cffa25183a0bb1e04cae642d73f3ed31d6bd4f9fdf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8448dff4de3470b229012a478a40eae949c1dedba595763baf7dce4468bf257d"
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
