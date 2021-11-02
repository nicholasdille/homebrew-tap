class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.33",
    revision: "be2ba0672cf45820e35245e55c33e9394369b982"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.33"
    sha256 cellar: :any_skip_relocation, big_sur:      "b7d5a13fcfdbf8da66302459a8e112b8189c4d91681cffd32c7043e37245d39e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4aadd5aa7de05c234300bc6e0ae26e31526607ef13959aa525178b84b378f74b"
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
