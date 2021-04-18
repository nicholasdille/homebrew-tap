class Ignite < Formula
  desc "Tool to ignite a Firecracker microVM"
  homepage "https://ignite.readthedocs.io/"

  url "https://github.com/weaveworks/ignite.git",
    tag:      "v0.9.0",
    revision: "e560f6242254868dfd92b7954866ba6f0f5779fc"
  license "Apache-2.0"
  head "https://github.com/weaveworks/ignite.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ignite-0.9.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "88cdc3b0d52a2a6c150d360797309482791296b0ec5188cadb010ada3690ebca"
  end

  depends_on "go" => :build
  depends_on "make" => :build
  depends_on arch: :x86_64
  depends_on :linux
  depends_on "nicholasdille/tap/cni"

  def install
    # goarch = Utils.safe_popen_read("go", "env", "GOARCH")
    goarch = "amd64"
    system "make", "GO_MAKE_TARGET=local"

    bin.install "bin/#{goarch}/ignite"
    bin.install "bin/#{goarch}/ignited"
    bin.install "bin/#{goarch}/ignite-spawn"
  end

  test do
    system bin/"ignite", "version"
  end
end
