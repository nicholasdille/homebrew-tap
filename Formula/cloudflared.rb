class Cloudflared < Formula
  desc "CloudFlare Tunnel client"
  homepage "https://github.com/cloudflare/cloudflared"

  url "https://github.com/cloudflare/cloudflared.git",
    tag:      "2022.7.1",
    revision: "06f7ba45233942b72349685fb7ede38c2783dd65"
  license "Apache-2.0"
  head "https://github.com/cloudflare/cloudflared.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/cloudflared-2022.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "216cf77eb17883a421ce82fb62f2e3e19d4b04fba87baa1fa68f2ca97cfffcd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e6d9452f8bced12dce161a37edfd7bc5a59a51cc6f61bc0194608f9825746231"
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
