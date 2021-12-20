class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.21.3",
    revision: "8e57dee86bb5910c3aae392912d0fa593cf88f9e"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.21.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "26603995a4b5a19e929d885fb885ee85bc9ecd5e62357b85899d743b19c75ac6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3ddad0cfb570a7923ccb53f7881a7c15f8cbd44f91537bcda58ebc764e0cd973"
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
