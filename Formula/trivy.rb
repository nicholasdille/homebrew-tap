class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.25.1",
    revision: "aa3d6966251476d5265df0f8387e6970daf6c922"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.25.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "ed5020657c7982745c7edf13e5a4c099e4454f31a55a81d759ee40cae3b5314c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "783d680b2948bcfdc785b3690bed3e989690e5a6b533086a6163c85af7a3dfb8"
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
