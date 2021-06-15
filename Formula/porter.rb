class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.2",
    revision: "d792a97eb6b83e8564a5d85dfc254dc6192a9f2b"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.38.2"
    sha256 cellar: :any_skip_relocation, catalina:     "8aca4943c257246aba8e878c90ef23add16fbbf9f017c7d272ffe506ee583820"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "89fe8671d4a2e1758955973939f509b15138a1de082c7f22ab23da2c811cc129"
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
