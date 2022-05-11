class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.5.1",
    revision: "7bcab138c51cb3af7caa910de6181ccd9b23a015"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "39118f6b1a2097033c9e6bdc4e00c1373b63c84828c68d1f452876a4f79ae326"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5a262d1256175bec9e3a048252f59dec953f4c3d77b4d49b4cc345b36bbde818"
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
