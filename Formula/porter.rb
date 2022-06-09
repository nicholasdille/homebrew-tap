class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.12",
    revision: "26b4ba0edbf7e2f5b39504ad83d3d56f0f43caed"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.12"
    sha256 cellar: :any_skip_relocation, big_sur:      "ed4b728b1444d98bf77e06ceb4e850b29f9a0c8884ef68b33a0f5eee2e925355"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3c3c8c4581c73c2f182a83fddfd8257aebaa2b84cef5f0b403360f43a22a7571"
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
