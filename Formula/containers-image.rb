class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.16.0",
    revision: "3ed4f40160d306006741bac0005985d6b1f88c60"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.15.2"
    sha256 cellar: :any_skip_relocation, catalina:     "238f574c57f24c18d2085c860e00ec24073d694682fabf545a10e07d64f190cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8f13f910057f69c2310e5b1b562b82f617c82322dce4e46bc456da676713f2a"
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
