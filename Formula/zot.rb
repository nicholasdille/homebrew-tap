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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ec06a2145592bfa210d9e79f7e33a36852d738178aead6d9e2da6ab0a17976c"
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
