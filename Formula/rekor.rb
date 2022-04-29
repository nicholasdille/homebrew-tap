class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://github.com/sigstore/rekor"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.6.0",
    revision: "5c52ad228cb698ea4320dada5cd0a7cd31a5eb9a"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.6.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c17aebc9555064a9164b663af659fdf8559771039d77a86a334560191fbf3401"
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
      "-ldflags", "-s -w"\
                  " -X #{cli_pkg}.gitVersion=#{version}"\
                  " -X #{cli_pkg}.gitCommit=#{commit}"\
                  " -X #{cli_pkg}.gitTreeState=clean"\
                  " -X #{cli_pkg}.buildDate=#{timestamp}",
      "-o", bin/"rekor",
      "./cmd/rekor-cli"

    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X #{srv_pkg}.gitVersion=#{version}"\
                  " -X #{srv_pkg}.gitCommit=#{commit}"\
                  " -X #{srv_pkg}.gitTreeState=clean"\
                  " -X #{srv_pkg}.buildDate=#{timestamp}",
      "-o", bin/"rekor-server",
      "./cmd/rekor-server"
  end

  test do
    system bin/"rekor", "--help"
    system bin/"rekor-server", "--help"
  end
end
