class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.3.0",
    revision: "e4303a87b92081e162e080ff69f36830c1035c09"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.3.0"
    sha256 cellar: :any_skip_relocation, catalina:     "f8d686bf0de49244f9504505534ff6185bd7080d8bbd9ca4d40e030ac4dfcbeb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "611b81a6af70fe4c1785c5c2c4d557f00ad31a332d867dc1acc54279ade03cba"
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
