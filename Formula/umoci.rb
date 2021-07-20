class Umoci < Formula
  desc "Modifies Open Container images"
  homepage "https://umo.ci/"

  url "https://github.com/opencontainers/umoci.git",
    tag:      "v0.4.7",
    revision: "17f38511d61846e2fb8ec01a1532f3ef5525e71d"
  license "Apache-2.0"
  head "https://github.com/opencontainers/umoci.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/umoci-0.4.7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d55567ad07a9450c99a33d0931eeb2a78c6aa51e4953b510b0ec4294508e4733"
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
