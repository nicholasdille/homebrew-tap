class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.24.4",
    revision: "06659f1509a19f601d7f7ff0cfe221f87c466566"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.24.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "25ae314849b103f64d29f3a8fbe20e6a4ed10d85ef1190ff8e4b9bf888d85b75"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4f0938b96de3a3a7c5c486b9dc853beddc4f60be1fde158dff97f907acd902b5"
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
