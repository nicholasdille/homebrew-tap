class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.25.4",
    revision: "b4a7d6a86111c4f634b75e0708646a6cdb0747fe"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.25.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "8c66c0a9295ca76ef56210198089b31775da4ea9941747eede0c09db358ecb0f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "76bbaa0effbb514cead4b2696735d94f9740aad69746a0c1e21015f0516c96b8"
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
