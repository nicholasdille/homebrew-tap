class Yasu < Formula
  desc "Yet Another Switch User"
  homepage "https://github.com/crazy-max/yasu"

  url "https://github.com/crazy-max/yasu.git",
    tag:      "v1.19.0",
    revision: "5152cc27059d2302fa014a8c33b628de79260767"
  license "GPL-3.0-only"
  head "https://github.com/crazy-max/yasu.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/yasu-1.18.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fbac1e3857327012b2e1abe42ccb276fd25b609208d760631181d608f936bc61"
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w " \
                  "-X main.Version=#{version}",
      "-o", bin/"yasu",
      "."
  end

  test do
    system bin/"yasu", "--version"
  end
end
