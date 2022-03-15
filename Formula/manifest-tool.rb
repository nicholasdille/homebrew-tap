class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v2.0.3",
    revision: "65590ecce1d4af199724d235dbb5453e10cad420"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-2.0.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "598e504fe1c514aea46b8ea48ea9d2d1b8b299a63920a7ce79070a4da7757378"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be153f9717ec3005eafc6a29fe1457a11962448c126637712611c7db126107b2"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "auto"

    (buildpath/"src/github.com/estesp").mkpath
    ln_sf buildpath, buildpath/"src/github.com/estesp/manifest-tool"

    system "make", "static"
    bin.install "manifest-tool"
  end

  test do
    system bin/"manifest-tool", "--version"
  end
end
