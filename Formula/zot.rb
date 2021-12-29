class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.7",
    revision: "cac7fe48544b7712f880bd9d6e063129e1799a89"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "50b094d734c76b9edb364f3da72b218081c9a8fadf631cd94e9180dff2124c44"
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
