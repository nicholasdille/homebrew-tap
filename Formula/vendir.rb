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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.30.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "568c2de97966a6072669ce063df126954056aae2f348dad727124cbc9cdefbe1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9400484130d7ceb8cf81f4eefbbcc60c87810d36dc7e5bdca6243c020519795f"
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
