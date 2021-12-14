class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.69",
    revision: "a3dc1ff848cdcf33a56c87f50af4fe560bdeefe6"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.69"
    sha256 cellar: :any_skip_relocation, big_sur:      "5120f0545c04d6a239e6ae0f76c2625ec0a2e1ccfed1bae0cc51120c5343ce12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "918fdcdf88159cd1ba958835cf8fdfa000245aa92bf6f036e29d7c529d5a29da"
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
