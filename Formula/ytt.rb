class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.36.0",
    revision: "ecab3989ffcd7733152047bf8b4c5f237803a56f"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git",
    branch: "develop"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.36.0"
    sha256 cellar: :any_skip_relocation, catalina:     "6bd054f57e7b96cbd09f3d6e32fcf1808161770b96da4b99d700140a8e9e57cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f87498fa1fa30b26d808dc69b43129d8f3946b82dd70d8ba4a57f192fd59f8eb"
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
