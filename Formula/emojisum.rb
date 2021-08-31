class Emojisum < Formula
  desc "Emoji that checksum"
  homepage "https://github.com/emojisum/emojisum"

  url "https://github.com/emojisum/emojisum.git",
    revision: "cdca4cf09ee39ed6db5f0d90a2f6eddcdd9fd0c6"
  version "0.0.0"
  license "GPL-2.0-only"
  head "https://github.com/emojisum/emojisum.git",
    branch: "master"

  livecheck do
    skip "No tags or releases"
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/emojisum-0.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "2d2e8894aef1ae94ebaae69af0e175ad3085952adfbe193b460023b3483afb64"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "458b33a7f8b53df0de78d977a9fd4f753580e9c30a9a762882513067a2b49f03"
  end

  depends_on "go" => :build

  def install
    dir = buildpath/"src/github.com/emojisum/emojisum"
    dir.install (buildpath/"").children
    cd dir do
      ENV["CGO_ENABLED"] = "0"
      ENV["GO111MODULE"] = "auto"
      ENV["GOPATH"] = buildpath

      system "go",
        "mod",
        "init"

      system "go",
        "mod",
        "tidy"

      system "go",
        "build",
        "-ldflags", "-w -s",
        "-o", bin/"emojisum",
        "."
    end
  end

  test do
    system bin/"emojisum", "--help"
  end
end
