class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v1.0.3",
    revision: "505479b95ee682b7302a76e86f3b913d506ab3fc"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-1.0.3"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:      "92abbf5e26cbcb9cd59d5680e27c98c43c1191aa53883707b9330e2ee5f4dd77"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32a695f9ffbab830d56414c234590d9f9f2723506f0af4278c957d06a2c5839a"
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
