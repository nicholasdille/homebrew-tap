class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2021.10.4",
    revision: "588f1a03c43091cc324d783dc75b5f4857cf4d5e"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2021.10.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "ccd582dae1fd8ca840df699bde1cf5de949cc83fbe9b647eaaff7a190b2cac8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "557bb9dbba10b05b1d28dc5753a31a7ae44bb3b9b5f4c4e3c524a64cda4cf945"
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
