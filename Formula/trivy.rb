class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.25.2",
    revision: "9c19298f5f4d4bfa52dd1de7971e26d8f96375b1"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.25.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "f76a18c53a885538756d241c57199396559064fc242c4cd41f5a3c2a912f8d1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f95cf7307a85218a58d24a6d127f6864d0e726af874e1cd9c4f78ad2738f4b0a"
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
