class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.31.0",
    revision: "0b8c690e3dc3edeba1e819d13de67ec3c22aa322"
  license "Apache-2.0"
  revision 1
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.31.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8e845f45184b91f09272dea8eefb1e4713c8828b76fc7d61cbf2fc489101a97"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags=-buildid=", "-trimpath", "-o", "ytt", "./cmd/ytt"
    bin.install "ytt"
  end

  test do
    system "#{bin}/ytt", "--version"
  end
end
