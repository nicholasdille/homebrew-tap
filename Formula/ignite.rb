class Ignite < Formula
  desc "Tool to ignite a Firecracker microVM"
  homepage "https://ignite.readthedocs.io/"

  url "https://github.com/weaveworks/ignite.git",
    tag:      "v0.10.0",
    revision: "4540abeb9ba6daba32a72ef2b799095c71ebacb0"
  license "Apache-2.0"
  head "https://github.com/weaveworks/ignite.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ignite-0.10.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6402ae21aee932aa7ef40b59b9f0aa88e03af50377e06ec1d44bb3816ad0b446"
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
