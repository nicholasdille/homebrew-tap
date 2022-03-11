class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.26.0",
    revision: "1655a8e5ca8dcc3e9535aedd3617b7a3bb7dca15"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.26.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4d2e8f3632c401adc999bffd476af53d5574dbd52a98d324a73126fc4bba70d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9c0aef282d62f115a406d80d204a53d841bc14a5de59154bc6076499865d544a"
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
