class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.0",
    revision: "c8779d9e87d9ca000fcaf82732071787a345a377"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "de32969b5f59aa2d4adf0745e00b165c64076eb57b250ef578223c6f931fc251"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a44613e4d759b725e0f89b7e10e3fb9081459da538fb1e5592c7ca6e16dc6a56"
  end

  depends_on "go" => :build

  def install
    system "make", "binary"
    bin.install "bin/zot"
  end

  test do
    system bin/"zot", "--version"
  end
end
