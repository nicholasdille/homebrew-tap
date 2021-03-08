class Ignite < Formula
  desc "Tool to ignite a Firecracker microVM"
  homepage "https://ignite.readthedocs.io/"

  url "https://github.com/weaveworks/ignite.git",
    tag:      "v0.8.0",
    revision: "77f6859fa4f059f7338738e14cf66f5b9ec9b21c"
  license "Apache-2.0"
  head "https://github.com/weaveworks/ignite.git"

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
