class Norouter < Formula
  desc "IP-over-Stdio. The easiest multi-host & multi-cloud networking ever"
  homepage "https://norouter.io/"

  url "https://github.com/norouter/norouter.git",
    tag:      "v0.6.4",
    revision: "f3c34b485dd908a2dcb5db864bce49af6dae88c5"
  license "Apache-2.0"
  head "https://github.com/norouter/norouter.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/norouter-0.6.4"
    sha256 cellar: :any_skip_relocation, catalina:     "a789b04d72fd18fd1e235c351fc403eae25731d75b5aef863d96db834adef05b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78bbeefe12260a90fc91de70546d5f58ddf622724eebd085ba27474fbe1207ec"
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
