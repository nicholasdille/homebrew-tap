class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.19.0",
    revision: "cfd3b41759d7e097ca674943b636a380b6e9c1fa"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.19.0"
    sha256 cellar: :any_skip_relocation, catalina:     "01f5b7337a66d2b74219cbf17189881143cdf5c13011d2952cbbdf9c64081ef1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2f31113989994bdf4f5f91b0ae31c8ccba1e3f43c7de53f2cb4e950592095e7"
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
