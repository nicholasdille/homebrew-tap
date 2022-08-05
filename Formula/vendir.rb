class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.30.0",
    revision: "9dd41a08ed60519a26f8537100998e1755541c40"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.29.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8c6beebaec475ae62945731bd55ac7eefee1972cad855416a6e5f62a1a954ae7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6fed0993fd681249a26d02574ed59b85b5efcd996625d09f950e1ed3c19eee6"
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
