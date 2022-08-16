class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.8.1",
    revision: "e09c62a7961c73bdab1f2f71cdd6e8f5c56a0bc4"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.8.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "643c0d37c96b8c97ad53ab47871a96b56f44a8ee7c8a475103117836bb9dcf33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fbb57b1912a36817509fb27e37edf6d951946a1b185ac0aabe469108350f45a1"
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
