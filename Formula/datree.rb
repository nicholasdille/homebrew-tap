class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.15.18",
    revision: "dcb5604e6e2dbb7191fb24461763b801805666c4"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.15.18"
    sha256 cellar: :any_skip_relocation, big_sur:      "4df9043ea7c28251eb4af887c22a43bbc4bb78eccaeb5d4042141c3a7fd59207"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3dba0fd18ade1aad71c5ca6237b91ef16cfe3837d3b2b8150585af1e0958264d"
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
