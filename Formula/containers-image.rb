class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.15.2",
    revision: "ff3e9ab32da333791572b19ca84936d6be7a68b8"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.15.1"
    sha256 cellar: :any_skip_relocation, catalina:     "b612eb52c93990f9b74f7fabcb7d0303fcf7b11b48924c15135e077fa47855f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4bf7f8b19e11eca1c1a8e0f142aec629a0b4b8e311869bd66d09f4a822e82909"
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
