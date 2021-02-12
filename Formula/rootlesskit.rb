class Rootlesskit < Formula
  desc "Linux-native fake root for implementing rootless containers"
  homepage "https://github.com/rootless-containers/rootlesskit"

  url "https://github.com/rootless-containers/rootlesskit.git",
    tag:      "v0.13.0",
    revision: "f6717f3e7add04bc4dbe81e0b1a696b4ce052b47"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

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
