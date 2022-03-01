class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.20.0",
    revision: "ad6a5c0e847ce0e575e77dfc24b86d95aae562e9"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.20.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "52a64a78484b18ba23fcd3a616ff12d3a261f699155618c087373601ed3f0fe0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8da696decdd2c9426a3d4d1d081d27082a0ec4e723c4969ea822db8f11777d74"
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
