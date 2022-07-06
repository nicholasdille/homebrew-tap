class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.7.0",
    revision: "ac7fdd5572007bb8b5ccb7d466f0461ee9977627"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.7.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "262bc3b9e9dbc7d3dbc2bdd82afac944d174a8917149d8c21ab29f9afffe6d01"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "99fb67ff1438735cb85b14c1bc70fc93fd00ebf1c8dddf227d40e9d22fc7eb21"
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
