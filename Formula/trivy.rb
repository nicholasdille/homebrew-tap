class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.29.1",
    revision: "6ce9404c167963e3a1581df96b889995994cfdac"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.29.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "786033080279e6c25e5e33de4bafb0a6cf8f6dc120c8e6e6fb8fe5eef98b36e5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9e306fa5bdb5998ca854faaeb4c3672fe33863e99dc3c3e08a8aa1aed8512a3c"
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
