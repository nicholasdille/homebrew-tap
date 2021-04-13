class Vndr < Formula
  desc "Stupid vendoring tool"
  homepage "https://github.com/LK4D4/vndr"

  url "https://github.com/LK4D4/vndr.git",
    tag:      "v0.1.2",
    revision: "f12b881cb8f081a5058408a58f429b9014833fc6"
  license "Apache-2.0"
  head "https://github.com/LK4D4/vndr.git"

  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/LK4D4/vndr"
    dir.install (buildpath/"").children
    cd dir do
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath
      ENV["CGO_ENABLED"] = "0"
      system "go",
        "build",
        "-ldflags", "-s -w",
        "-o", bin/"vndr",
        "."
    end
  end

  test do
    system "whereis", "vndr"
  end
end
