class Vndr < Formula
  desc "Stupid vendoring tool"
  homepage "https://github.com/LK4D4/vndr"

  url "https://github.com/LK4D4/vndr.git",
    tag:      "v0.1.2",
    revision: "f12b881cb8f081a5058408a58f429b9014833fc6"
  license "Apache-2.0"
  head "https://github.com/LK4D4/vndr.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/vndr-0.1.2"
    sha256 cellar: :any_skip_relocation, catalina:     "028b4552b2eeb29e52bc4c3c0ca63feacbb4b6e233b3348b5d0bdd75c78c77e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "086d6e1aba7c462ac586e5dec9ba52e599a597366e91c6b843f7c85adb39e838"
  end

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
