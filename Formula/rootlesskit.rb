class Rootlesskit < Formula
  desc "CLI tool for spawning and running containers according to the OCI specification"
  homepage "https://github.com/rootless-containers/rootlesskit"
  url "https://github.com/rootless-containers/rootlesskit.git",
    tag: "v0.13.0"
  license "Apache-2.0"
  head "https://github.com/rootless-containers/rootlesskit.git"

  depends_on "go" => :build

  conflicts_with "nicholasdille/tap/rootlesskit-bin"

  def install
    system "make"
    system "make", "install", "BINDIR=", "DESTDIR=#{prefix}"
  end

  test do
    system "#{bin}/rootless", "--version"
  end
end
