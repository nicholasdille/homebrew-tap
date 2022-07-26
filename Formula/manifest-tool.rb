class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v2.0.5",
    revision: "87f93c02a4ee1cdae9e768f097310a14129fdfcd"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/manifest-tool-2.0.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "704c3f1851ff28d68c71acd9411e259853038d8cf6763f3b8ece83527942772d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b668f4389e5e982557aeb516af3dd9fe71cac5ce350761d9fe998bb38f6c2f6f"
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
