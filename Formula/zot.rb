class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.5",
    revision: "627cb97ef139583ea1246e76ad0c76396be3c7fc"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "820b819f19f07b36f77c3ced24242c335a2cb724bebf96fc562a5960c693420c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "18fcd50a8df48ebd8d01638984c6bca64ebacebe6bb2ffc4364590b5ef4465eb"
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
