class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.28.0",
    revision: "afe32928436231e6c05602fd15359c7432520167"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.25.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "6d73c17088f389eb811a17508e3166e0477578f25dcc902f16d56a72d3f4911f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "32a6328339881cce35d7673846422365471a5c0923cc5fd3ca7a0b16a418929b"
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
