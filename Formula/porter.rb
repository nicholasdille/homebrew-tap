class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.37.3",
    revision: "7890a7e2ed0035b71e2eee985b5e1aa3c451f758"
  license "Apache-2.0"
  head "https://github.com/getporter/porter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/porter-0.37.2"
    sha256 cellar: :any_skip_relocation, catalina:     "7b37efc651d82a461f43fba9aa656edb434223572b0cf61af60024b021a7271f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "461ea8280fdecf98b99328d2891592f1309fcc80078aaf92c39406bba415823c"
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
