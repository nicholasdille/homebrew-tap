class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.3.1",
    revision: "f44e496dd92c7dfb2d68c2b93654892bd9680a94"
  # license "MIT"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.3.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "4226fa2aaa9535c0146db19ab491bc55eb180d8ea4e0e9eb03450d67c0905323"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5d4fc9491c67700f8c2240f3d838c9880085df952c171d10c9b40c4d28fdcf4a"
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
