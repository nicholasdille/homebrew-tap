class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.2.0",
    revision: "f8449e8a350d31cf3b28e9a32b7e2521baf3a842"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.2.0"
    sha256 cellar: :any_skip_relocation, catalina:     "5fc7296c53fa2d9d65814ff0080e4baa2095ea9b8bbcaff4d7a0b96165d77590"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "52e42fd403b4246c847154981c3bccc209340828e038a6ebc15abba11210cfdc"
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
