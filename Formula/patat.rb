class Patat < Formula
  desc "Terminal-based presentations using Pandoc"
  homepage "https://github.com/jaspervdj/patat"

  url "https://github.com/jaspervdj/patat.git",
    tag:      "v0.8.7.0",
    revision: "911d8281997a7fd95b60bbeb58ec24e115d808ee"
  license "GPL-2.0-only"
  revision 1
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/patat-0.8.7.0_1"
    sha256 cellar: :any,                 catalina:     "808c71bd0c1a113b5b443320e58fe9fc9d6c786337cbae505a2d354fd3c213b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ce0863a438203dd93871fcdf79a04c21b2673b7958ab3bdaaf3d351b6960f49"
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build
  depends_on "zlib"

  def install
    system "cabal", "update"
    system "cabal", "v2-build"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    assert_match "#{version}\n", shell_output("#{bin}/patat --version")
  end
end
