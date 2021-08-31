class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.16.0",
    revision: "3ed4f40160d306006741bac0005985d6b1f88c60"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.16.0"
    sha256 cellar: :any_skip_relocation, catalina:     "56f2bea9ff199608391fdfd71be17b3bb942a94c608cc6743ce4d0ee1acaa0cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2c7349b3fd4f3e928fffa1cd2a1a88bd1a44a806f0936dccceb9466725b0b5e"
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
