class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.36",
    revision: "291fe1d160b2e83b9807d8a3bf82a03aff7f1483"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.36"
    sha256 cellar: :any_skip_relocation, big_sur:      "57b4699326e3842508ac1419786748d62b789e8ad9606dab2fd6436d29f3b55d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56c65aeb5bb253fb107a6b7b6b5651f501f064db5d41b422780e560ca76bab29"
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
