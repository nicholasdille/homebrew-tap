class Ignite < Formula
  desc "Tool to ignite a Firecracker microVM"
  homepage "https://ignite.readthedocs.io/"

  url "https://github.com/weaveworks/ignite.git",
    tag:      "v0.8.0",
    revision: "77f6859fa4f059f7338738e14cf66f5b9ec9b21c"
  license "Apache-2.0"
  head "https://github.com/weaveworks/ignite.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ignite-0.8.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "65bd47f2aeca99eabf1f1cbe0d2da4235ec8082225b49bc5abe2679ba17a45a6"
  end

  depends_on "go" => :build
  depends_on "make" => :build
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
    system "#{bin}/ignite", "version"
  end
end
