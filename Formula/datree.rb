class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.5.0",
    revision: "ed6aaafc11f198ff42fb2b8356f6bea2eac7400b"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.5.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "a2662809680b45f4a7e8c28319fb9f0c57134d9d7b457d956424004ceca35bed"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3f539a3a6adcff4a038008f312e6551c31d388c130becc361cb3cb28f4571557"
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
