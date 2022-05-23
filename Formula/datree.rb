class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.28",
    revision: "3ee556518be669c4b5e921544f33429a2bcc6e24"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.28"
    sha256 cellar: :any_skip_relocation, big_sur:      "d0424efce3d9bb12f69f77fd0340f08cf3f89796839af402d3c2844786ec1760"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7dd92d160cf71f5f1f31b71f370e14142ee4ba22c9b3e2953818fe5cf91f09b6"
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
