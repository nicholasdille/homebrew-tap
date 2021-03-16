class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v0.14.0",
    revision: "81d7d047d09a5b93645817ec580181de7a984082"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-0.14.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bb5f78012ab56e603205462afab99908f7699f9e9dec03629bf365e2bf80e0f6"
  end

  depends_on "go" => :build
  depends_on "make" => :build

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
