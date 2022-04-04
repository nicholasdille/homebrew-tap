class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.1.20",
    revision: "a95075558f35ae1313897f7fc381518c3025320f"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.1.20"
    sha256 cellar: :any_skip_relocation, big_sur:      "4bf11308d10bfec38abb51601359b33fe91da45000da55b6e5c1326622f2821a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "41fa3d77e3748d575ae34ca9e9d3dac7bbff5e96e29af7786aa727d9dfac7094"
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
