class ManifestTool < Formula
  desc "Tool for manifest list object creation/query"
  homepage "https://github.com/estesp/manifest-tool"

  url "https://github.com/estesp/manifest-tool.git",
    tag:      "v1.0.3",
    revision: "505479b95ee682b7302a76e86f3b913d506ab3fc"
  license "Apache-2.0"
  head "https://github.com/estesp/manifest-tool.git"

  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/estesp/manifest-tool"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GOPATH"] = buildpath
      system "make", "static"
      bin.install "manifest-tool"
    end
  end

  test do
    system "#{bin}/manifest-tool", "--version"
  end
end
