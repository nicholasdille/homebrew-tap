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
    sha256 cellar: :any_skip_relocation, catalina:     "28b9f16900ba3e800965f921a3d712048542f7b29280e4844e9f943adcdc6536"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "190b95fc54643ce7abf1c288cc62acabd58fc3dea7254e296b0a4402f3896d71"
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
