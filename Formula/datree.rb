class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.0",
    revision: "920d861490d2b669b6c4462cbcf7180374b61fda"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4f88d1f85d81ff80393d659201e92407f4e670c6b91d87bc7fc611e18961add1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "75cac6dda1643a20368a5e1a5ba2783ecc32e71e1519dda1cdab652f57621930"
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
