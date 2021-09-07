class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://developers.cloudflare.com/argo-tunnel/"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2021.8.7",
    revision: "11c06b5a1fdcc30d42b867c62ea6fe1cb80ba6d3"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
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
