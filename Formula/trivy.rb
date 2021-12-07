class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.21.2",
    revision: "7beed3017042af21993eafa7842fa29debb74e60"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.21.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "c09f844ef9df9b2f70c869a1899866768f6664dbf8b2d452fedaa0131964b9b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "94b1c56898a4ce141e1884b843c321c3871a571e861b6d87906602565b6d5fda"
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
