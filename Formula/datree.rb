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
    sha256 cellar: :any_skip_relocation, big_sur:      "36d306603cfa370d181d94b267611b35518b5442b0dcf87b6c79d82b32981b33"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af1baada46c981065127d69ada38446f6c60575bc06b9be62d63d3d50e8aafed"
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
