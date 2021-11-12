class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.2",
    revision: "8e4d8288677a0fed78a27c1756a22e9b73737f2e"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "c20fe8c8642df7dbfd23ce67a947bc071711e8cbc415e4cac56f2b016fbb1ea8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fae525b5609a4a82a56327dec2b322c48ee44a5b0593dc8eaf632eecf0e0b6b4"
  end

  depends_on "go" => :build

  def install
    system "make", "binary"
    bin.install "bin/zot"
  end

  test do
    system bin/"zot", "--version"
  end
end
