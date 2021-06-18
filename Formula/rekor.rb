class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://sigstore.dev/"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.2.0",
    revision: "f8449e8a350d31cf3b28e9a32b7e2521baf3a842"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.1.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0cd3a03e4196fe5106f5ef36fe39938b4c54e8f8bc54bd72f14fa15d585125f4"
  end

  depends_on "go" => :build
  depends_on "nicholasdille/tap/trillian"

  def install
    ENV["CGO_ENABLED"] = "0"

    cli_pkg = "github.com/sigstore/rekor/cmd/rekor-cli/app"
    srv_pkg = "github.com/sigstore/rekor/cmd/rekor-server/app"
    commit = Utils.safe_popen_read(
      "git",
      "rev-parse",
      "HEAD",
    )

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
