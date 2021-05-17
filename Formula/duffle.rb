class Duffle < Formula
  desc "CNAB installer"
  homepage "https://duffle.sh/"

  url "https://github.com/cnabio/duffle.git",
    tag:      "0.3.5-beta.1",
    revision: "c364840933b1886eddc01462090ea0494fc6bcfb"
  license "MIT"
  head "https://github.com/cnabio/duffle.git"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/duffle-0.3.5-beta.1"
    sha256 cellar: :any_skip_relocation, catalina:     "815770017010cdfce8701a2968c1a597031cfed90007abef9d0ea94358b7c9e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8a93740e114c089ba8bad5768930d63744de9149682ea50373220694ca8bfde"
  end

  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/deislabs/duffle"
    dir.install (buildpath/"").children
    cd dir do
      pkg = "github.com/deislabs/duffle"

      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      ENV["CGO_ENABLED"] = "0"
      system "go",
        "build",
        "-ldflags", "-w -s -X #{pkg}/pkg/version.Version=#{version}",
        "-o", bin/"duffle",
        "./cmd/duffle"
    end
  end

  test do
    system bin/"duffle", "version"
  end
end
