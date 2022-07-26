class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.30.4",
    revision: "f9c17bd2d87b9c02da1eebd21dd45ce1ccf97995"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.30.4"
    sha256 cellar: :any_skip_relocation, big_sur:      "20148463bd194e5ebceac6c451d19349455d1b8a2a929bdbfb0e142068377752"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "81f11935123133d0d9415ce842139647a37422a8a74b5ff984518c1d61ccdf63"
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
