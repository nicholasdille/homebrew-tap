class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.1.22",
    revision: "f6662ea382bd17da51026bf5ade00e5e5464d5bf"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.1.22"
    sha256 cellar: :any_skip_relocation, big_sur:      "25ee5d0d2d51ed9d4571af86c2c8f2e2ba11a8a63743cf304a16a1304a4af2c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "85bfbf055250c1a156237bac4c3414b4bca26bd51e53c66e1c51730dcb77bc50"
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
