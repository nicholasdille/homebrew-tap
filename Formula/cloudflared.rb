class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2021.11.0",
    revision: "43f1c6ba82acd65e98c087a1cd9723cd6dc5e4fa"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2021.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7d64b6c9699b37f268b5e1275e428adac1627537f0e5bf173bca6b7627ab5d58"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b29d13fc8a0e020e0cfb4d2c6deb328923efbf43bd5a609ff267d57e073791fb"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/cloudflare/cloudflared"
    timestamp = Time.now.utc.iso8601

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      "-v",
      "-mod=vendor",
      "-ldflags", "-s -w"\
                  " -X main.Version=#{version}"\
                  " -X main.BuildTime=#{timestamp}",
      "-o", "cloudflared",
      "#{pkg}/cmd/cloudflared"

    bin.install "cloudflared"
  end

  test do
    system bin/"cloudflared", "--version"
  end
end
