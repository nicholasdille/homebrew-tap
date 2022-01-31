class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.23.0",
    revision: "449add24af3a2ef8d1f19a32d282001cc425c7c9"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.23.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7983405058acfc0c1e41eb774e6582a15420ee59b7bf613fdb74e384cc4e0d23"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "70164281cedb01550fd061b7029d71a7c1faed90fed7d19cbf4437bff620d0db"
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
