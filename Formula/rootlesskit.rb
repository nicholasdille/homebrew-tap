class Rootlesskit < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://github.com/rootless-containers/rootlesskit"
  url "https://github.com/rootless-containers/rootlesskit.git",
    tag: "v0.13.0",
    revision: "f6717f3e7add04bc4dbe81e0b1a696b4ce052b47"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

  depends_on "go" => :build

  def install
    system "make"
    system "make", "install", "BINDIR=", "DESTDIR=#{prefix}"
  end

  test do
    system "#{bin}/rootless", "--version"
  end
end
