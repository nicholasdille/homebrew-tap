class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.41.0",
    revision: "f9826a6c32acd4f14ee2b5cfea824d7f3a9a25ee"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.40.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "cd2eb17f519ca271985a76c12b78fda4eae4797906372e1af74deafb014cb4cf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f5f2d517366a1c5a198ee861e1032f9e254125363125fb7a79a9e65c6373b06d"
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
