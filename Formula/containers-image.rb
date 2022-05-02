class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.21.1",
    revision: "3535abd765b81eb59981684532eca94e2e586127"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.21.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "5d0ba790a26d35377c416d71824dce2b5f4a3d3d44e884769239dd4125d99215"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "65a24867822d9d24cd18de23ada3c4c279a6a4e9a3e04008ba70c741933d15f7"
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
