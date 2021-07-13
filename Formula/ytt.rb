class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.35.1",
    revision: "0daec8963dcdaa38971d0f7d2b7f3174fb5a77de"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.35.1"
    sha256 cellar: :any_skip_relocation, catalina:     "58b3f0cb2716e6f1d9089f0c08fd44f7828c07227cd06a3e1060da34f22bf27f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "281e0f8e4d7c270d2df7b68dbc5793fd18ffc3e2f4d05b3f844b509d0ee3b144"
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
