class Gometalinter < Formula
  desc "Concurrently run a whole bunch of linters"
  homepage "https://github.com/alecthomas/gometalinter"

  url "https://github.com/alecthomas/gometalinter/releases/download/v3.0.0/gometalinter-3.0.0-linux-amd64.tar.gz"
  version "3.0.0"
  sha256 "2cab9691fa1f94184ea1df2b69c00990cdf03037c104e6a9deab6815cdbe6a77"
  license "MIT"
  head "https://github.com/alecthomas/gometalinter.git"

  bottle :unneeded

  depends_on :linux

  def install
    bin.install "gometalinter"
    bin.install "gocyclo"
    bin.install "nakedret"
    bin.install "misspell"
    bin.install "gosec"
    bin.install "golint"
    bin.install "ineffassign"
    bin.install "goconst"
    bin.install "errcheck"
    bin.install "maligned"
    bin.install "unconvert"
    bin.install "dupl"
    bin.install "structcheck"
    bin.install "varcheck"
    bin.install "safesql"
    bin.install "deadcode"
    bin.install "lll"
    bin.install "goimports"
    bin.install "gotype"
    bin.install "staticcheck"
    bin.install "interfacer"
    bin.install "unparam"
    bin.install "gochecknoinits"
    bin.install "gochecknoglobals"
  end

  test do
    system bin/"gometalinter", "--version"
  end
end
