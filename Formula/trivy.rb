class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.30.2",
    revision: "80c7b91637a60f54cf8545bf3798f0dab0992e3c"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.30.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "e30a7df9b519ac6556b2f9177c089aadb4d9b2c38a7cc695b2fe862f6d855e46"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "78079db3839f46c348a79389093322c45a05aae4a6ba45b1e3942370e0d95d2b"
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
