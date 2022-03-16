class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.24.3",
    revision: "4b8bf874d88172635bc329554e35de29722bb139"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.24.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "206ce849ab586042e306c25cfbaa72c2f73a7b2e8799b586d0b0f1bbc733f18f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8ca6e26ab495f77208febf48be5284261fdbf6c414977d888ab6f480a4d4c10e"
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
