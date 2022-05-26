class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.28.1",
    revision: "f19243127a068889a19bd4aa34cbf7858e5dd33d"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.28.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "e0659257bb94d651431ca6ed9b04ac9e4594f770917787052a7ea4a319a38170"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ff833933d5aa094856e8861a1b8cfbbe64071fbd6eaa3ec0e146c75a36599f38"
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
