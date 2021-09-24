class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.6",
    revision: "43d077da18b6725029da4396fd0c0fd1c926e4b6"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.6"
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:     "77fb6597e1b9c3334e75a5c5e05a1eaede4583bd7e9a11aab03e762ce7b420fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f6226aa5ee10db680b074425800aa2075ca57371eb7373cd0060c72b376cb301"
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
