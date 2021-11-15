class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.3.3",
    revision: "5c07e19c8d8c7e309c6c523a2419e40be4ac43c6"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/zot-1.3.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "3617ebd461a0701bd24a86e4bf9687102680cc692f6ce5b75dfe48f233f1424d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cff9721bdf2124572d6a179ebb0998827c6e226bcc055710f33b1396f1ec42d6"
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
