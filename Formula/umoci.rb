class Umoci < Formula
  desc "Modifies Open Container images"
  homepage "https://umo.ci/"

  url "https://github.com/opencontainers/umoci.git",
    tag:      "v0.4.7",
    revision: "17f38511d61846e2fb8ec01a1532f3ef5525e71d"
  license "Apache-2.0"
  head "https://github.com/opencontainers/umoci.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/umoci-0.4.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fe05d61ba5ec50d67774af4b123621ad08d2c509548eb9f98a2b7a64ef74629a"
  end

  depends_on "go" => :build
  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "umoci.static"
    bin.install "umoci.static" => "umoci"

    system "make", "docs"
    man1.install Dir["doc/man/*.1"]
  end

  test do
    system bin/"umoci", "--version"
  end
end
