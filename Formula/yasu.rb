class Yasu < Formula
  desc "Yet Another Switch User"
  homepage "https://github.com/crazy-max/yasu"

  url "https://github.com/crazy-max/yasu.git",
    tag:      "v1.17.0",
    revision: "2137b4f80f9eaf1ec6b8d9f384c9f833018b5a4a"
  license "GPL-3.0-only"
  head "https://github.com/crazy-max/yasu.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build
  depends_on :linux

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X main.Version=#{version}",
      "-o", bin/"yasu",
      "."
  end

  test do
    system bin/"yasu", "--version"
  end
end
