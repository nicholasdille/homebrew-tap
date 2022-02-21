class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.21",
    revision: "356dfb25530476da63e17b854c5b518c57f9714e"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.21"
    sha256 cellar: :any_skip_relocation, big_sur:      "7e8683dad5570267b3c5273115bc79e2c69907f312b20a9f57725d9dcfe3ad77"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8f11a8bdea43b7cac3e414104d8c8dfba39d13f6e2f8e7b36bf0134d99a72edd"
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
