class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.8",
    revision: "408f043f1e619cf3b9913fdf9d2c52249d537b35"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "befe1eb28a01f25a5be91bdf26388d84e593113854355f291a203b2c223a160a"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    system "make", "binary"
    bin.install "bin/zot-linux-amd64" => "zot"
  end

  test do
    system bin/"zot", "--version"
  end
end
