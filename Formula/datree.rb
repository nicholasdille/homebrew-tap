class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "0.14.17",
    revision: "f1b58f5ba63f54df81ef7c08f2cf22b3221f13ea"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-0.14.17"
    sha256 cellar: :any_skip_relocation, big_sur:      "0a0f78501b1251e16b9908bb69f6fef862495540839bdaa28b957f5dcd0609c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7db56874572b350c8d98d230db0997012caddba528465171765873b15a5d516"
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
