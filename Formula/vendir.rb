class Vendir < Formula
  desc "Easy way to vendor declaratively"
  homepage "https://carvel.dev/vendir"

  url "https://github.com/vmware-tanzu/carvel-vendir.git",
    tag:      "v0.22.0",
    revision: "502a9268ea2af7a84ea739fcdad8fe1364e2c453"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-vendir.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vendir-0.22.0"
    sha256 cellar: :any_skip_relocation, catalina:     "906be7d5571e81f91eed305f7c704f0100d1997b99496cd9102a1cbd17bac320"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5986f2b913797865d3cf8012e943d0a4b2486396ce82ded584665d6a98ce5794"
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
