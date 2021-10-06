class Goss < Formula
  desc "Quick and easy server testing/validation"
  homepage "https://goss.rocks/"

  url "https://github.com/aelsabbahy/goss.git",
    tag:      "v0.3.16",
    revision: "6e5d3e37bb1facb315fa9f49b523b7e41496dfa8"
  license "Apache-2.0"
  head "https://github.com/aelsabbahy/goss.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X main.version=#{version}",
      "-o",
      bin/"goss",
      "github.com/aelsabbahy/goss/cmd/goss"

    bin.install "extras/dgoss/dgoss"
    bin.install "extras/dcgoss/dcgoss"
    bin.install "extras/kgoss/kgoss"
  end

  test do
    system bin/"goss", "--version"
  end
end
