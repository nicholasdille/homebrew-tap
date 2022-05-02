class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v1.0.1",
    revision: "5d5f4c0c26e26a6b51d1838c23e793e5836442d0"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-1.0.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe1f6651d21577eb94fe43005f41b8f31b34764b6fa24fd3162dc694687d1179"
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
