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
    sha256 cellar: :any_skip_relocation, big_sur:      "0b6a4e7a0a8437ba6c35977e226d1753094ceff51f8ed2eda3b9366db338c211"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d43e0403b0707b9837738c00dbe7f1196c8282835be5d496190eba67048a3944"
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
