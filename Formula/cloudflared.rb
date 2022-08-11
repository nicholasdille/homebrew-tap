class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.8.0",
    revision: "a768132d378f97cc4a3cabef67296f7aaa8738c9"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.8.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "86d769a2600b0e919c1cb8a2a5a01268f399b4198422604ea209af6fe7c9ccc2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8d97ab615583c39699cd90be96f8ccfaa1b5a3806a1bf48c6cfe11febc302eb9"
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
