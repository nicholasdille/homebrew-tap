class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v0.14.2",
    revision: "4cd567642273d369adaadcbadca00880552c1778"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-0.14.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0372ed6ec588ddbf8fdcc6bb0d779bc2028a3e31ada483d1a721b55b7fa13005"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "make"

    bin.install "bin/rootlessctl"
    bin.install "bin/rootlesskit"
    bin.install "bin/rootlesskit-docker-proxy"
  end

  def caveats
    <<~EOS
      Make sure that newuidmap and newgidmap from the uidmap package are available.
    EOS
  end

  test do
    system bin/"rootlesskit", "--version"
  end
end
