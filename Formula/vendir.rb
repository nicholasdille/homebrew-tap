class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.17.0",
    revision: "e1c02e2f30380a1f211fbd1fdda402765caf7047"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  depends_on "go" => :build

  def install
    system "./hack/build.sh"
    bin.install "vendir"
  end

  test do
    system bin/"vendir", "version"
  end
end
