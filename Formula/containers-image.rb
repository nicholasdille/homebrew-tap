class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.17.0",
    revision: "de81eaebe16b32d47b891c5b0d0c3f1f7ba0a368"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.17.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "0dbf40a5672650df8d391cead0dbfb24f8713e70cd23f9a754a7523c94862680"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b840dfad1ab653094aca3b2b2267ca9fcb504682783d312bd9ee2d16ca16e24c"
  end

  depends_on "go-md2man" => :build
  depends_on "make" => :build

  def install
    system "make", "docs"
    man5.install Dir["docs/*.5"]
  end

  test do
    system "true"
  end
end
