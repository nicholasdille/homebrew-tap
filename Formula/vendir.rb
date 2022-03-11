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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.25.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "86d8cad3598ce55bba3cf86300c2226e0d254fad05bac512d609e44d8a4f36a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0540147f02f386cdb3a9d41efdac32a274f786c28ebcfe9217e32a6323fd6988"
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
