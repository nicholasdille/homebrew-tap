class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.4.1",
    revision: "d5ec175475d8b07b01986640e4f5b5fc827526cb"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.4.0"
    sha256 cellar: :any_skip_relocation, catalina:     "07b8c14cba9966b7ab6323edb7f9062921b93c7ed5e7df29a767e8a51a937f66"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d341a7c831741f2aaf1bf678096bc274e8afe4716ee151bcc71c5563515eb3d6"
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
