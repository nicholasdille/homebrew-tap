class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v2.0.4",
    revision: "0e4d8b32fec16134b7d0b7ea837af25cd10a1ed8"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-2.0.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "f64701c308b2aff1987fc7bfa3b79549e29d5fd7de28825fb91bb94dbadfcdc5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "782a88b76233e4c2ac63d56a404e97fb723b16a27cb4b14036457a82a80a01c6"
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
