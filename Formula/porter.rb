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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.10"
    sha256 cellar: :any_skip_relocation, big_sur:      "d73d68fe9ca65a15b3619370101fba804396c4805899b23fb8404894c299a115"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a456c81de88347be9b016d3b5fe49dcd391815400a25ec6fbf791e2f6083d149"
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
