class Diun < Formula
  desc "Receive notifications when an image is updated on a Docker registry"
  homepage "https://crazy-max.github.io/diun/"

  url "https://github.com/crazy-max/diun.git",
    tag:      "v4.21.0",
    revision: "778c13852623e0da78e7c903109e10cd958050f6"
  license "MIT"
  head "https://github.com/crazy-max/diun.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/diun-4.20.1"
    sha256 cellar: :any_skip_relocation, catalina:     "95d45e33182b8f35f01cc7750edb13e563f1b8cc9481fe988f973b561cf1220f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "67ab83bd7c3027fd22a7d1c0561455b4b9aa251ace2e6b92513805abf0cc2a2a"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "mod", "tidy"
    system "go", "mod", "download"
    system "go", "build",
      "-ldflags", "-s -w -X main.version=#{version}",
      "-o", bin/"diun",
      "./cmd"
  end

  test do
    system bin/"diun", "--version"
  end
end
