class Emojisum < Formula
  desc "Emoji that checksum"
  homepage "https://github.com/emojisum/emojisum"

  url "https://github.com/emojisum/emojisum.git",
    revision: "cdca4cf09ee39ed6db5f0d90a2f6eddcdd9fd0c6"
  version "0.0.0"
  license "GPL-2.0-only"
  head "https://github.com/emojisum/emojisum.git"

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
