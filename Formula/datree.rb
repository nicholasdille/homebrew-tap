class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.4",
    revision: "6536c538574ae5d216a6058af54b51a0b9d0fba6"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "060049bfc3bc784d3ab8f99b8069467e90aee205f9c656d4995ae97dc1c4dd71"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc495b079d26febb60351267ccb0a88dd427ca84147bb38eda95bedb6d50cfbf"
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
