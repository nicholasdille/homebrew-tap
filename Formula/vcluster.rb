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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.3.2"
    sha256 cellar: :any_skip_relocation, catalina:     "358bc4f3e565f1e44c9e346d5b833389caff354e0d85b98a1769dc36b10f3e7c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "228359b9c21fcbf1ff26d8c9a7d799aaf0d511e6796e93328b333b95d15ef3b5"
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
