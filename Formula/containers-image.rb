class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.22.0",
    revision: "40af9b508afc0268ee2731054e1916c52dd7af89"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.22.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "9ff956972cbdc022a60ad3f2197e2197b2a6cc3ca267dcdd7111b5f18ccef064"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6bb5d5502925245577fce347f1f1a31c3a5aa1ae14007adb66d5cca38887a287"
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
