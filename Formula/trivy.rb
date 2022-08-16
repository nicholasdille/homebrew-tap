class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.31.0",
    revision: "917f388852b39a0d31da4a17a73c7302b3dc0d6f"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.31.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "a2f73589e1561ae2cae83dd12bbc8e4ef85da4b1f5e8ca340cdda0482c4a5abe"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec1f9d5c05c8589222cbd0428bd5baee4d0c87b620a6c921f4cd760b7079fd32"
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
