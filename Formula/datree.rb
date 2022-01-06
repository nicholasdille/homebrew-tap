class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.95",
    revision: "57672498f6973a6cf7ae1cd826f95d64947bf1a9"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.95"
    sha256 cellar: :any_skip_relocation, big_sur:      "82842323f5089a2fad1050bfa4305bd8240881bb6ed0ba9ab74e9fddf640230b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "aeb84a824d9f1e32e1dde5bfa905f2559f58658fe06e3158fcff4559d74f86a9"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/datreeio/datree"
    ENV["CGO_ENABLED"] = "0"

    system "go", "build",
      "-tags", "main",
      "-ldflags", "-X #{pkg}/cmd.CliVersion=#{version}",
      "-o", bin/"datree",
      "./main.go"
  end

  test do
    system bin/"datree", "version"
  end
end
