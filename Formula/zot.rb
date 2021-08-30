class Zot < Formula
  desc "Vendor-neutral OCI image registry server"
  homepage "https://github.com/anuvu/zot"

  url "https://github.com/anuvu/zot.git",
    tag:      "v1.2.8",
    revision: "c6670b13295ffe69bcab59c655d5b02e2c13b9ab"
  license "Apache-2.0"
  head "https://github.com/anuvu/zot.git"

  livecheck do
    url :stable
    strategy :github_latest
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
