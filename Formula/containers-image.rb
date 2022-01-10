class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.18.0",
    revision: "b30c330d18d0b1cfd19567b83511a3f92b3d196b"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.18.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "f2a01bf4d0d6c8213e56f4ea78c37a14181e02d2664b3a6c183072b97db8f7fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5673e40b848a9929b31ad728f681acc332dd52193d4a0a5d76611c49ed093e55"
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
