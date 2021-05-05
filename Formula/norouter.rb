class Norouter < Formula
  desc "IP-over-Stdio. The easiest multi-host & multi-cloud networking ever"
  homepage "https://norouter.io/"

  url "https://github.com/norouter/norouter.git",
    tag:      "v0.6.3",
    revision: "e6a1cc1e4a11d8aef8ae5184eb5960224efc1772"
  license "Apache-2.0"
  head "https://github.com/norouter/norouter.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/norouter-0.6.3"
    sha256 cellar: :any_skip_relocation, catalina:     "09517b82f0ac4af00e29a98dcef1dec4dd8f3726f244cabc24cf82bd134055fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "71ced95474b687cda3ce1b6cf3c93927bf5295ed0a5f16acab187c3a68228b10"
  end

  depends_on "go" => :build

  def install
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o", bin/"norouter",
      "./cmd/norouter"
  end

  test do
    system bin/"norouter", "--version"
  end
end
