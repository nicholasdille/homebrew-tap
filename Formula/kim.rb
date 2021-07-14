class Kim < Formula
  desc "In ur kubernetes, buildin ur imagez"
  homepage "https://github.com/rancher/kim"

  url "https://github.com/rancher/kim.git",
    tag:      "v0.1.0-beta.4",
    revision: "1d7e0d4ec149c826a5281ce59261b3283bef0198"
  license "Apache-2.0"
  head "https://github.com/rancher/kim.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/kim-0.1.0-beta.3"
    sha256 cellar: :any_skip_relocation, catalina:     "439c808c31fbbdd420beae1a24c257c6fab9b7de2ac1a25783b0af59b5bea2dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5bfd4aba0e81d4d27b767857e10b383701b6403868ec4140827911430fc96dbb"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    dir = buildpath/"src/github.com/rancher/kim"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "make", "bin/kim"
      bin.install "bin/kim"
    end
  end

  test do
    system bin/"kim", "--version"
  end
end
