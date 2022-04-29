class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.4.1",
    revision: "d727d3ade60cc4ed8838faf9cd1359f57bd0bb51"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.4.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "1c361924e8211a0c3806cc21e0dd6705cd27e4bcdc2a7390151aa27494f50574"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "39e0670a4466871cbeae28203d5855cf3887272794682c024dca167493e3ee75"
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
