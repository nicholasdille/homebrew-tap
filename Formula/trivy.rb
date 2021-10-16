class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.20.1",
    revision: "bcfa0287b9321710158d7edce6dbc234b3c9cdbf"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.20.0"
    sha256 cellar: :any_skip_relocation, catalina:     "380e17849919c9f7a06c9b316179636ada7dbb8332d42179d8c0e84f730b8d30"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42d1d6ae33fdccbc79881084fc2606e20226742ab4051aeebc999107f2870bb1"
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
