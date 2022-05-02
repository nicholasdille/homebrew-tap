class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.11",
    revision: "7db0ea7d5766bf6b1b4b23e6b3e76e8195045a8c"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.11"
    sha256 cellar: :any_skip_relocation, big_sur:      "44abf66f2cf3c5ff1ec86043516502d2b6825ee5d084db037505b80f1f597574"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "330df77ff93e127344c3550d3e7cba9daeffed7fecb11653c3ab23fbcaf3166c"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "packr" => :build

  def install
    ENV["GO111MODULE"] = "auto"
    system "make", "build-porter"
    bin.install "bin/porter"
  end

  test do
    system bin/"porter", "--version"
  end
end
