class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.29.0",
    revision: "cb76acbd9fe407a9596aad8f1e7f82abfbf3a2ef"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.28.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "5ff5ec089633d23c1c94dde49450cefc739ed432ede00c93d60cbabffa17433e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c7d8840cc5ae32461c2f16abafb5149ec2cc7a1ee7317de7709ca9e322bdef9b"
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
