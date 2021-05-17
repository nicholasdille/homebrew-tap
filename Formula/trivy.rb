class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.18.1",
    revision: "eaf2da20a690874570509e9924e2d5f1680c813d"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.18.1"
    sha256 cellar: :any_skip_relocation, catalina:     "39f0a787322df34f73c5f682c7c971d1ebba8b2bc7097882b45615fad02444d2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4affdd819010cd96b384487e920b625e660a6dcc41d58ef254c2499131cfe95e"
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
