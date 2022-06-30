class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.28.0",
    revision: "bcb9c646a3a92a2c1a0bdec55ceb04d218be37d6"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.27.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "61e46ced2e49dea28813c177720d370c40372aefa8db2d1af13e59d8028fcc63"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc17a96aa4a0cfd4d64d6b76e13612d24b76b7ac5dabe35ae154882ea1451d9d"
  end

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "vendir"
  end

  test do
    system bin/"vendir", "version"
  end
end
