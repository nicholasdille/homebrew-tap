class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://github.com/sigstore/rekor"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.10.0",
    revision: "83a4094253c9267d664dfddcf44ad5929a626bee"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.10.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "89d9eb90bcb625509f38527a5bcb41ad5dedca6c46441393aeb6b3c671eadc8f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "45636dd3dc04615f51759338434863a48293e3c091e00defd5e53ce707d397b7"
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
