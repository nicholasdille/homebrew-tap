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
    sha256 cellar: :any_skip_relocation, big_sur:      "a6bd721feb036391093ecb824c0c5f31b174dbc5c5b4d895075d28a04b5849cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0b2f981fac545c6c7b5064fc89bf20a9e34c3aedfc14a0eb36ce7099ff032e0e"
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
