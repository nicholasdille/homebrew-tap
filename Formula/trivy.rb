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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.21.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "4e8d327fb1f6ee8bfc3f9ac7dd34ac7813d93982993fd740c7b01cd885b92ca9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a513daa690f9b19b6e9a80a272526d3960d5abfa5b7090cd396f6337eed9b452"
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
