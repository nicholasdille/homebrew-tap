class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.2.2",
    revision: "9cd2780079c7ae2cede9f018a94f685ccf6156d6"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.2.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "8acde8359dfe3a0fa60da7b133e47fba1c0f01e8f5e80e78fcb3724b2982cb12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7071476a4941a6cb5d4a6574aba88afe32b6b1607ef8a79f9d3e54cb01fca91b"
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
