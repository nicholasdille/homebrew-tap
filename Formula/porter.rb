class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.5",
    revision: "a4694cd7347785676642f6eb5804ea9a830c3e9a"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.4"
    sha256 cellar: :any_skip_relocation, catalina:     "95c1b4721fdcd013481730c792bbea522be2cac023ca464db0c435577f9dae20"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "89a954f226cc7b2d6176f78b3c5c76674493a87bc6db27410a72726157cde93a"
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
