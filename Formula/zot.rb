class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.6",
    revision: "c61c3836db9fd472864bcf497d9fbd97269b02e3"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71216ca0eefcf2f583a7c6a447cc965140a0251523bead6f18b0e9f2d1e6b42e"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    system "make", "binary"
    bin.install "bin/zot"
  end

  test do
    system bin/"zot", "--version"
  end
end
