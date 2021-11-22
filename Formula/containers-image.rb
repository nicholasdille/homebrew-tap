class ContainersImage < Formula
  desc "Work with containers' images"
  homepage "https://github.com/containers/image"

  url "https://github.com/containers/image.git",
    tag:      "v5.17.0",
    revision: "de81eaebe16b32d47b891c5b0d0c3f1f7ba0a368"
  license "Apache-2.0"
  head "https://github.com/containers/image.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.16.1"
    sha256 cellar: :any_skip_relocation, catalina:     "42a49ab46f3b723aaceb7e2874797f8579d5f09a462a2b10018b0b8b8525ecd9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ee108212a95732b3dca494e80f70284d6d68399d9fb08fb19fd33252eab2ebb8"
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
