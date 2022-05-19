class Goss < Formula
  desc "Quick and easy server testing/validation"
  homepage "https://goss.rocks/"

  url "https://github.com/aelsabbahy/goss.git",
    tag:      "v0.3.18",
    revision: "a2aa3d062b469aa790c92142f4af608a98dc64b0"
  license "Apache-2.0"
  head "https://github.com/aelsabbahy/goss.git",
    branch: "master"

  livecheck do
    url :stable
    regex(/^v(\d+\.\d+\.\d+)$/i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/goss-0.3.18"
    sha256 cellar: :any_skip_relocation, big_sur:      "12ac781991f06bf06a8bb121b3ffe05bbd3514f98f35f2e6686483595dfc7047"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b63f9c265095b181f48f7d83441188ea0dea1064011790546cb140ded667a756"
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
