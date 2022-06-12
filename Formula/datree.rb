class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.9",
    revision: "26b6f340b3d03e24385f647179841c577e6c38f8"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.9"
    sha256 cellar: :any_skip_relocation, big_sur:      "427adf03c4e7b251bdab30ee77007ec98990a313d0057ba9141aacc4040cd500"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b79e18b1e18fbd3c6be32aae8abdb4e68fb3718fe1e68a17cf2b6d2bfcfcb066"
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
