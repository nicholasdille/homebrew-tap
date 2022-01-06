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
    sha256 cellar: :any_skip_relocation, big_sur:      "6acd3aebcde15f75588b1d4bcad2bad75c68e05c34b094e234795d98b7caa32c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "646d5addf6f2470d34ce177359eccad5b336f243f909454e76e73317c6e49baf"
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
