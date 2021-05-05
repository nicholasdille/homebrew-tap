class Porter < Formula
  desc "Your application and everything you need to deploy. Together"
  homepage "https://porter.sh/"

  url "https://github.com/getporter/porter.git",
    tag:      "v0.38.1",
    revision: "3018b91c22ddcfcb34f71458d22f02f2977af14f"
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
