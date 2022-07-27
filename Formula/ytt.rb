class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.42.0",
    revision: "b43289cd4f0ab4d828e36fe48dbfddb27dc5b553"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.42.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8909d96a0de5d82cbd9046c332a11774cd7679561ddf942e344842e7c3b75213"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5f82402843493c9ea72d74a757a9146eda4bb7abc726939219a009c7f223c931"
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
