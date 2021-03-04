class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.31.0",
    revision: "0b8c690e3dc3edeba1e819d13de67ec3c22aa322"
  license "Apache-2.0"
  revision 2
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.31.0_2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "daf94fb6891b3db6f9bada5205e1a8f4e50deea3dcbe614f5c3f6df2da07cd8f"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", "#{bin}/ytt",
      "./cmd/ytt"
  end

  test do
    system "#{bin}/ytt", "--version"
  end
end
