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
  depends_on "zlib"

  def install
    system "cabal", "update"
    system "cabal", "v2-build"

    timestamp = Utils.safe_popen_read("git", "log", "-1", "--format=%cd", "--date=rfc")
    ENV["SOURCE_DATE_EPOCH"] = Utils.safe_popen_read("date", "'+%s'", "--date=#{timestamp}")
    Utils.safe_popen_read("patat-make-man")
    (man1/"patat.1").write output

    output = Utils.safe_popen_read(bin/"patat", "--bash-completion-script", "patat")
    (bash_completion/"patat").write output
  end

  test do
    system bin/"patat", "--version"
  end
end
