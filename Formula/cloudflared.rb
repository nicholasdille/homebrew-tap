class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2021.12.4",
    revision: "7c7cf688e636e4efc1a9a5016ae66f34b2c9fdee"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2021.12.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "4e0e201e08ecdd477a7289207ffa9057df255b9d83118a89ecbc99c1b2c6cee9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc7a67af0e9996e719c424044e24712408ff5a3f562c30971914227163e2c9b5"
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
