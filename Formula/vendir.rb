class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.29.0",
    revision: "9a6109a4a47d934a9db6c279deaee0c91f0bad19"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.28.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "e984457ad0565722eaae95287102c62e72d5fd23ce299c3d1a48aa6ed5fd49fe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6c3155dc80a6dca0c5aaab9fde8df37d974e717606fd0cf9140cb7afc7c5c0f0"
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
