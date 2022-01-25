class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.19.0",
    revision: "7bdefff09962f9958ca1961817f90b1cd53f0852"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.19.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "e962f9e8f65a4017a261ad8990dea116c823582b292394877aa79bec95898b4f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bafafbf20ac3e31e22f0d8c9e2362c49d42d7e69065465b4f1db541e4b620f56"
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
