class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.7.1",
    revision: "06f7ba45233942b72349685fb7ede38c2783dd65"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "2cfc7ec3820a4945aed4634992c8f8edead6b10d50b62a620dc7a02766dd9d08"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "11adc8a09990528ab38903a1e094c98165681fa19956226b75bbed6b51b581eb"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/cloudflare/cloudflared"
    timestamp = Time.now.utc.iso8601

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      "-v",
      "-mod=vendor",
      "-ldflags", "-s -w " \
                  "-X main.Version=#{version} " \
                  "-X main.BuildTime=#{timestamp}",
      "-o", "cloudflared",
      "#{pkg}/cmd/cloudflared"

    bin.install "cloudflared"
  end

  test do
    system bin/"cloudflared", "--version"
  end
end
