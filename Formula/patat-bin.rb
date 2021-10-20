class PatatBin < Formula
  desc "Terminal-based presentations using Pandoc"
  homepage "https://github.com/jaspervdj/patat"

  url "https://github.com/jaspervdj/patat/releases/download/v0.8.7.0/patat-v0.8.7.0-linux-x86_64.tar.gz"
  version "0.8.7.0"
  sha256 "6ddd248448c83806d5233842c39e0c4f9a7948946ac5ddf977702c9dfbc22052"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    strategy :git
  end

  def install
    bin.install "patat"
    man1.install "patat.1"
  end

  test do
    assert_match "#{version}\n", shell_output("#{bin}/patat --version")
  end
end
