class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v0.13.1",
    revision: "5c30c9c2586add2ad659132990fdc230f05035fa"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rootlesskit-0.13.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "90b5aa1bd79adbacab1b95418a676c237383a3f1e940dcf0c78d0054bb95a9a2"
  end

  depends_on "go" => :build

  def install
    system "make"

    bin.install "bin/rootlessctl"
    bin.install "bin/rootlesskit"
    bin.install "bin/rootlesskit-docker-proxy"
  end

  test do
    system "#{bin}/rootlesskit", "--version"
  end
end
