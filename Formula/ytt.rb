class Ytt < Formula
  desc "YAML templating tool that works on YAML structure instead of text"
  homepage "https://get-ytt.io"

  url "https://github.com/vmware-tanzu/carvel-ytt.git",
    tag:      "v0.35.0",
    revision: "ce83de435ce1663b22bd001efc486a88752f545e"
  license "Apache-2.0"
  head "https://github.com/vmware-tanzu/carvel-ytt.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/ytt-0.35.0"
    sha256 cellar: :any_skip_relocation, catalina:     "cafc0bb1fafc61fe1aaa55b469bc70c954de650fc5fe43e220ce984c2326e735"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a36d27fa53304db9a04886d20de3856219042baf47465fa2dfd1234978772948"
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
