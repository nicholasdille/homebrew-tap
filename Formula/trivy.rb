class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.16.0",
    revision: "cdabe7fc9e74000911269228ebe3cb59f3879df4"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.16.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7e45519deed98356956b252968cfc9eb2a7096083b7d838d2b96b9184b0b5741"
  end

  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "describe", "--tags")
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags",
      "-s -w -X=main.version=#{tag}",
      "-o",
      "#{bin}/trivy",
      "./cmd/trivy"
  end

  test do
    system "#{bin}/trivy", "--version"
  end
end
