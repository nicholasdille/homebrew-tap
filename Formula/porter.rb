class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.37.3",
    revision: "7890a7e2ed0035b71e2eee985b5e1aa3c451f758"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.37.3"
    sha256 cellar: :any_skip_relocation, catalina:     "b7e2922452af41843530c2f16b8d219d8ab2f7ba97296e719a87edb5d481a691"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0a0650aba356902629272843845bd0a2dc3480b42bbd93ff0c4401f864cd46a5"
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
