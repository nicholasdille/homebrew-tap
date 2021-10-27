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
    sha256 cellar: :any_skip_relocation, big_sur:      "6fd5a12dc5eb98312f17c8706d6a4d3dd28dc0f31a253d11c754727729a37d72"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "92686d947494365498b12aab7a62307b00b6dd4922773442fe930c86d7cd76a5"
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
