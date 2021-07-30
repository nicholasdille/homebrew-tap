class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.15.0",
    revision: "1cb6aacc6d0b912c2cc1c91f03bf2531e60d126d"
  license "Apache-2.0"
  head "https://github.com/containers/image.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.15.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e9138c7cc01ab85a8253e62507a14feadda9a34a2c927bc3ee57762920eca30d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2f1ad4806e81973bae8d264518b0a3ec84d43c5768e328eb6e32b924a5373197"
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
