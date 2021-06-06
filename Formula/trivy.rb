class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.18.3",
    revision: "85e45cad958c60245f848a9cf3bf103bb8efdd6e"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.18.3"
    sha256 cellar: :any_skip_relocation, catalina:     "c9bc685a1d0408bd501eb9dc4d9b684bcf0ee607c1e44f9504232ef8653a5386"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "276de15b8c532d1f0f20877007a5cc869b57e0bb09c61850cfb0317246ad6cf9"
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
