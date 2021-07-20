class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.21.1",
    revision: "8a4c8717553c36aed86edbc5c5331b1b47ef1b7b"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.21.1"
    sha256 cellar: :any_skip_relocation, catalina:     "3c9996f0f12fd35a8c2e5d0a5a0a8c2468cb33833f2d41d3bbe6170601191c73"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a2d5b16d0bc5f4de8b2f06857fd8d0d0bd3a48fbb3a80dbeaae68dddcbcf8594"
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
