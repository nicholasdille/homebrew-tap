class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://github.com/sigstore/rekor"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.8.2",
    revision: "bd717e77fb917c754c43329cf694066c34fbfe1f"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.8.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "d75551a091b2a1276e8ad9e8cd88b2774cdbee99adf992d2fe739e2874d274d4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4d8c2db7f2cb3f4aab0def717aaab7a905866100a794183dc2b0afd9e704078d"
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
