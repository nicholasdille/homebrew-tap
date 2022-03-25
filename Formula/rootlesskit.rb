class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v1.0.0",
    revision: "1920341cd41e047834a21007424162a2dc946315"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-1.0.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "483d353e41dd3b1058b7c500f084e961cd941193eaf301a8d80c8bd11dc6bf6e"
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
