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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.5"
    sha256 cellar: :any_skip_relocation, catalina:     "a6b0fd6ad7a0108b5c0056f0fd317627a5af0b9eb4ee96b25a8c29d8c42acdc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cb41ad443e3875ffcc419babb10af04e2899f47d47b7cb039b5b725bc627e96e"
  end

  option "with-btrfs", "Support BTRFS, requires libbtrfs-dev"
  option "without-devmapper", "Support device mapper"
  option "without-cri", "Support CRI"

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
