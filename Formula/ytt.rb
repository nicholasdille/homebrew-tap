class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.41.1",
    revision: "2a58cd709ad3e7a02383de32bbb7d31431f028fd"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.41.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "d2363bd59fddf021f39c20f0058b153497f60dc899894b34b772cb7e259f330a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "54c44fe1735947f71f28835fb13dfdb5711d8fbb3e1120ca083e95ded93edfc0"
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
