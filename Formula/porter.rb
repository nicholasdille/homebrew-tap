class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.3",
    revision: "5cc5e265bd0f0481554332f068ba9e0da299634c"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.3"
    sha256 cellar: :any_skip_relocation, catalina:     "9cdef728ecd94ce83c50fa78eb9e0c055d64d10ebd482eabf91e8433f2770b6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f7d46922edbd27af46a842b5a477edcd032a159eba62f462da22657c03421cad"
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
