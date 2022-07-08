class Rekor < Formula
  desc "Signature Transparency Log"
  homepage "https://github.com/sigstore/rekor"

  url "https://github.com/sigstore/rekor.git",
    tag:      "v0.9.1",
    revision: "fb4ed403d0ee6366a2a06c5703700af19864c90f"
  license "Apache-2.0"
  head "https://github.com/sigstore/rekor.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/rekor-0.9.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "5e8f2ea692c8137ab870f330836ff8d1e3b5023272fb0fad16ed70f5616ad4eb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "59af5087dbc88eba1ad90aba34268e3ebf4109100e61edf5ad8db95e205fef56"
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
