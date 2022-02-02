class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.39.0",
    revision: "cb4ee408e8892385c467bc496a567328cbe45690"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.38.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ec75ff09951bcc2358cc2112567a8287c86276d840d1f4b4ee3dc00aa6469f15"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d0e731bae4e64570339364e8c809778fc798b2712936942760dff59fc486971a"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags=-buildid=",
      "-trimpath",
      "-o", bin/"ytt",
      "./cmd/ytt"
  end

  test do
    system bin/"ytt", "--version"
  end
end
