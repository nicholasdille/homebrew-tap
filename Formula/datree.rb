class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.22",
    revision: "5958d6ef42b9d036178fdb9d9e1366cd526153ea"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.22"
    sha256 cellar: :any_skip_relocation, big_sur:      "fc5ad52da870f71988a3f073daeb8ce28c7c90b8fc0b7ca3fdb3c008937886a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be52b12d0013dd1045ea4e0a9749f84a98963416a77c1bb0f1efef253666ba57"
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
