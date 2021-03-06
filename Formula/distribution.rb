class Distribution < Formula
  desc "Toolkit to pack, ship, store, and deliver container content"
  homepage "https://github.com/distribution/distribution"

  url "https://github.com/distribution/distribution.git",
    tag:      "v2.7.1",
    revision: "2461543d988979529609e8cb6fca9ca190dc48da"
  license "Apache-2.0"
  head "https://github.com/distribution/distribution.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/distribution-2.7.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92ca1ff2e0537841a3c884529f11debf9e9aa5e4e065aebf4444b789e28850ab"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on "nicholasdille/tap/gometalinter" => :build
  depends_on "nicholasdille/tap/vndr" => :build
  depends_on :linux

  def install
    dir = buildpath/"src/github.com/docker/distribution"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "vndr"
      system "make", "binaries"
      bin.install "bin/registry"
    end
  end

  test do
    system bin/"registry", "--version"
  end
end
