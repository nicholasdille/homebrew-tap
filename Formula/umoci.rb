class Umoci < Formula
  desc "Modifies Open Container images"
  homepage "https://umo.ci/"

  url "https://github.com/opencontainers/umoci.git",
    tag:      "v0.4.6",
    revision: "5efa06acfb3bb4e65d2711cf5255970948e047cf"
  license "Apache-2.0"
  head "https://github.com/opencontainers/umoci.git"

  depends_on "make" => :build
  depends_on "go" => :build
  depends_on "go-md2man" => :build

  def install
    system "make", "umoci.static"
    bin.install "umoci.static" => "umoci"

    system "make", "docs"
    man1.install Dir["doc/man/*.1"]
  end

  test do
    system "#{bin}/umoci", "--version"
  end
end
