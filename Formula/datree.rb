class Datree < Formula
  desc "Ensure K8s manifests and Helm charts follow best practices"
  homepage "https://datree.io/"

  url "https://github.com/datreeio/datree.git",
    tag:      "1.4.35",
    revision: "a37cf84909e4d26c50224af9916145f7d9f67962"
  license "Apache-2.0"
  head "https://github.com/datreeio/datree.git",
    branch: "staging"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/datree-1.4.35"
    sha256 cellar: :any_skip_relocation, big_sur:      "d158f36af1ddd30c108e07a128f583a9412a896e50792db497b0a7dc3c8b8f80"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3ec0b745c8785fa7c81799f82b90b8f8961e8564beebd7c16b0fe79029d07e89"
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
