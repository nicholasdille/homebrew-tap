class Uptodate < Formula
  desc "Client and GitHub action to keep repository contents up to date"
  homepage "https://vsoch.github.io/uptodate/"

  url "https://github.com/vsoch/uptodate.git",
    tag: "main"
  version "0.0.1"
  license "Apache-2.0"
  head "https://github.com/vsoch/uptodate.git",
    branch: "main"

  livecheck do
    skip "Repository has no tags/releases yet"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/uptodate-0.0.1"
    sha256 cellar: :any_skip_relocation, catalina:     "f198de3b7ed0bcfa36b41157244da9d9ec93b5ab49aeba504fa752ec8ef9c5ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9badaee4a1b72b7d7989a1a7677e4a366ce61088b6351d3f4141ba6fd601d733"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w",
      "-o",
      bin/"uptodate"
  end

  def caveats
    <<~EOS
      Uptodate has no releases yet. Please reinstall to update.
    EOS
  end

  test do
    system bin/"uptodate", "version"
  end
end
