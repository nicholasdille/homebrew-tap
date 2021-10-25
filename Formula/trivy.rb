class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.20.2",
    revision: "5dc8cfe55d808c39ae0d785710a7107d6e6de06b"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.20.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "8217cbda4530427db027dd5b7562d988222a4d37081b5a476366c0e90cd5b655"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2946287d6fe0c65ccb0fea8c2e238ff7b9cdf91b2b8ee7e4c26631f21d88841a"
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
