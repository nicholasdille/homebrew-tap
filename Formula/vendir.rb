class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.18.0",
    revision: "0e6136473ca8c81d3daa4d473bd5efc81183cff1"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.17.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "005452202004fd7bdb6a9cdde59e99149ce3793307c1b0f070edfb6c8004d582"
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
