class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.33.0",
    revision: "1ae92de571727d9471528c9bfe49691d9745ae76"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.32.0"
    sha256 cellar: :any_skip_relocation, catalina:     "9bf9d009afe331ed40cc3d8943ad61868bfc5103483f5f3ffa2641f6209d2408"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "264e0d214ffaabd56c28a9676e742d4e2cd8925354ec9598a9d0f5dec95a01bb"
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
