class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v1.0.3",
    revision: "505479b95ee682b7302a76e86f3b913d506ab3fc"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-1.0.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "48c4a0f71ade48657c785982a4294326677cbba08035e8448b69e110ea1b6b66"
  end

  depends_on "git" => :build
  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/estesp").mkpath
    ln_s buildpath, buildpath/"src/github.com/estesp/manifest-tool"

    system "make", "static"
    bin.install "manifest-tool"
  end

  test do
    system bin/"manifest-tool", "--version"
  end
end
