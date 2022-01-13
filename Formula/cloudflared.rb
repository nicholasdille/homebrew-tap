class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.1.2",
    revision: "97309d81abf98f649ca9e3040d96fe631284cee1"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.1.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "3a6856ebcfa6127a8afcc1699a775041be0cf5818159352a5f36ee751f6c9615"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dc756dd439804de0e9f89864d709e90e8dd3fa4895c2ee9f735879ccf3722ea7"
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
