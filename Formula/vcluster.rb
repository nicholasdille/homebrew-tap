class Vcluster < Formula
  desc "Create fully functional virtual Kubernetes clusters"
  homepage "https://www.vcluster.com/"

  url "https://github.com/loft-sh/vcluster.git",
    tag:      "v0.4.4",
    revision: "16a48865fc1813c9da107be3f19059e8b9c5c9c0"
  license "Apache-2.0"
  head "https://github.com/loft-sh/vcluster.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vcluster-0.4.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "71b5fd5a2c3e0247a11200dc9fe1f0e7d71a77e433a5e7ce756f58f14585a6d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a6ac88e4e9b0cf4b8fff329a24d13b83ab6354a2bf22cf1c34a8ea374b88634e"
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
