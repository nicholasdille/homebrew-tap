class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.21.1",
    revision: "b9a51de862707d6e2a1fbc6f5967e93f4e94a517"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.21.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "c476e19ce8e6a6fb27394d40c1cd37f8465676a308a64af22194829a3aff900e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "fccc0926555d074623d84822d4bf8f89050247b82cb131fd3bfad956c600a179"
  end

  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "describe", "--tags")
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w -X=main.version=#{tag}",
      "-o", bin/"trivy",
      "./cmd/trivy"
  end

  test do
    system bin/"trivy", "--version"
  end
end
