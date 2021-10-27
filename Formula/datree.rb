class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.20",
    revision: "b774f92ea49cf4acaf771f21710392541adc2bb8"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.20"
    sha256 cellar: :any_skip_relocation, big_sur:      "d9e628f1fd85432c216d96f9766466786949101cbe746a1954adeed53b5e4722"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "91db79e40b8d8068ca54183824795dc096240cdb77dd6ed9ada728a324a8017e"
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
