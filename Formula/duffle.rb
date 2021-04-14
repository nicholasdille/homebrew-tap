class Duffle < Formula
  desc "CNAB installer"
  homepage "https://duffle.sh/"

  url "https://github.com/cnabio/duffle.git",
    tag:      "0.3.5-beta.1",
    revision: "c364840933b1886eddc01462090ea0494fc6bcfb"
  license "MIT"
  head "https://github.com/cnabio/duffle.git"

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
