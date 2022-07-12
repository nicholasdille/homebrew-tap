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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-2.0.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "c633d1f11a1837b0035697db39e68b70d091106f70652dab6cbd83f45c28659c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1ae18199b13022d8c74a3310e9a4601d057416ad4f8763814c8bcadc0663d085"
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
