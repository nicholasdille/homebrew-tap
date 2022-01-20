class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.5",
    revision: "4c5bdff01f44fbb946d309794e11085acda3c115"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.5"
    sha256 cellar: :any_skip_relocation, big_sur:      "beaecb8b8387973ef948caa496b3a73a1547e03829e092df6c67eb5a93e57129"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ca106eb49c38cec07d2f9078e525d455d82b4057051695c92261cb0329538a92"
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
