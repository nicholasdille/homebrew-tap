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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/containers-image-5.19.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "046aa8fb4dd70eb6d4f2a152c829915607bda52db285dbaedf3316ce06b82e5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dca6e17c1321da6e2892581d3814287aaae5e8ae0cb48b46eccc0ad84116d27d"
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
