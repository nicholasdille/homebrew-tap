class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.40.0",
    revision: "b50fd584133ce57a147c9fa050bd4acea684a259"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.40.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "af6809a2667d9343d371e68a997f2e161653bbab2541af3e6406d32e484f5cd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94fe775afe6141b40f8de116ed255a1bd63f77e15ee5f37b1330416ba2d733dc"
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
