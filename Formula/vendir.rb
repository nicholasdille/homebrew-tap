class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.28.1",
    revision: "ed16945007090dec99252ca468e6bd525c8ac534"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.28.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "bba88015d38f51afdc91cc019ac70a1b5388c8ca160b7a179baf48093c2d5396"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "99226a0b4d267a3f0df1d03d48392a250a37d7738cbe1b28eedc0125a5695e9c"
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
