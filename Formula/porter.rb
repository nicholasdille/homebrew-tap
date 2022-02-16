class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.9",
    revision: "1d6bd98fedc2053da5fd71700555f3e0fba0b579"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.8"
    sha256 cellar: :any_skip_relocation, big_sur:      "9fdb20a3706841c9c93bcda57a48710b1ebf281adb9bab8fcee736b4fa8178d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e24e7233684189d9a929fde12bab4aa9cf2f8273f3c9d68268ba056cf059f61f"
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
