class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.30.3",
    revision: "fa8a8ba7dc819c502b77f272ff0c239dcff7d9f3"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.30.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "cb270ab7048cf2214cc157af8152437d969a0cccf67a7a1e6ac7a90ccc4bdc95"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ad4f33338d115bad873b607ce516b39a0f323731b6f9123533ca62873c16409e"
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
