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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.29.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "73066378c79cda58f2dde9f84dfb60289aa9b7b867b687b20f0fbe20aa2369d7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a3513c13c684b6d31b043af57bfffc7967fd97054de4c931f644ecea8348e164"
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
