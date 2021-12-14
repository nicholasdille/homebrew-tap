class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.24.0",
    revision: "808f5c6fe806dfb3dc81a0adc7328ecf67951d77"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.24.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7ee4008ed9d17ae7d3466d55c482aaac703b0ad29014ffcf0a7f7a07e50e21e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d08fd50b0519f697af03a9967dbe4cc708a4762f4809f24e3f2aa517ce0ec6d9"
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
