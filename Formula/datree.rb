class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.0.1",
    revision: "c23cb3cb639ee144ad8dab50dff4e5e7857f65e2"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.0.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "1baa538598badd1b7511f57b85f1e0b4944398c55e5e060ba44e4e3bc6f5de72"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7a2b0f933329528723e54a2ff2f4c53049aa59061c443e188dded1b1db26aaf"
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
