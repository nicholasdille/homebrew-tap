class Tini < Formula
  desc "Tiny but valid init for containers"
  homepage "https://github.com/krallin/tini"

  url "https://github.com/krallin/tini.git",
    tag:      "v0.19.0",
    revision: "de40ad007797e0dcd8b7126f27bb87401d224240"
  license "MIT"
  head "https://github.com/krallin/tini.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/tini-0.19.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fba61c8a752fa5f43cdcae4affa4169c010027a6f540a7b62f49ed8c8da1794a"
  end

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "make" => :build
  depends_on :linux

  def install
    system "cmake", "."
    system "make", "tini-static"
    bin.install "tini-static" => "tini"
  end

  test do
    system bin/"tini", "--version"
  end
end
