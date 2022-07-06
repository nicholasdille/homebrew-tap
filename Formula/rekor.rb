class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://github.com/sigstore/rekor"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.9.0",
    revision: "66f5c0611e77d0ea15b718b958387e2d016f910a"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.9.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "cf07f69b51fa2102b93cdc96157928bf0653178b6e24814f4c591be62e8a1406"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6b962ded8957cba82c95cbdd701c12ab470a04ac165f8a288b79bd3266c856da"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/trillian"

  def install
    ENV["CGO_ENABLED"] = "0"

    cli_pkg = "github.com/sigstore/rekor/cmd/rekor-cli/app"
    srv_pkg = "github.com/sigstore/rekor/cmd/rekor-server/app"
    commit = Utils.git_short_head
    timestamp = Time.now.utc.iso8601

    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X #{cli_pkg}.gitVersion=#{version} " \
                  "-X #{cli_pkg}.gitCommit=#{commit} " \
                  "-X #{cli_pkg}.gitTreeState=clean " \
                  "-X #{cli_pkg}.buildDate=#{timestamp}",
      "-o", bin/"rekor",
      "./cmd/rekor-cli"

    system "go",
      "build",
      "-ldflags", "-s -w " \
                  "-X #{srv_pkg}.gitVersion=#{version} " \
                  "-X #{srv_pkg}.gitCommit=#{commit} " \
                  "-X #{srv_pkg}.gitTreeState=clean " \
                  "-X #{srv_pkg}.buildDate=#{timestamp}",
      "-o", bin/"rekor-server",
      "./cmd/rekor-server"
  end

  test do
    system bin/"rekor", "--help"
    system bin/"rekor-server", "--help"
  end
end
