class Uptodate < Formula
  desc "Client and GitHub action to keep repository contents up to date"
  homepage "https://vsoch.github.io/uptodate/"

  url "https://github.com/vsoch/uptodate.git",
    tag: "main"
  version "0.0.0"
  license "Apache-2.0"
  head "https://github.com/vsoch/uptodate.git",
    branch: "main"

  livecheck do
    skip "Repository has no tags/releases yet"
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
    system bin/"uptodate", "--version"
  end
end
