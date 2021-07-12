class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.19.0",
    revision: "dea3428804539fab563a6275e0ade489dca1885d"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.19.0"
    sha256 cellar: :any_skip_relocation, catalina:     "e583a22fc005c25de50dbb1e1975b1a0f8535917c2200c86df46d7d8436f5d59"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "77a525394999ca593a36166c8715ed6f3372ff9bcc3bc2ac9fd74e61dea0b810"
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
