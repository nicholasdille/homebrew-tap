class Patat < Formula
  desc "Terminal-based presentations using Pandoc"
  homepage "https://github.com/jaspervdj/patat"

  url "https://github.com/jaspervdj/patat.git",
    tag:      "v0.8.7.0",
    revision: "911d8281997a7fd95b60bbeb58ec24e115d808ee"
  license "GPL-2.0-only"
  head "https://github.com/marcosnils/bin.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    system bin/"patat", "--version"
  end
end