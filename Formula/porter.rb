class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.2",
    revision: "d792a97eb6b83e8564a5d85dfc254dc6192a9f2b"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.1"
    sha256 cellar: :any_skip_relocation, catalina:     "8c95105b1f410ec60c993dd28982e2a9c09cd4bef0234e916eb40605cbaa5d83"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "880ead83dd8461436eea4222ce88244b29498f7cd0655a480af25677c24ed708"
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
