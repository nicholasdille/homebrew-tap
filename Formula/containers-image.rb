class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.21.0",
    revision: "d03e80fc66b3051b2164aa0f834f312e29df7fad"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.21.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "303a4bd54e8ad15484be9420037d8248340182dbef5e12121419a4cc4c37023d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92b7441eec3047b7a7a31283b8674843db9aecdff08b96917693101bccaa3720"
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
