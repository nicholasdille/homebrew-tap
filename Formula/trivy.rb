class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.21.0",
    revision: "efdb29d0d4bfafb9f18aca4658cf306e7634e095"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.20.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "1a727ce49d7b8664046818a428f8d115bba1e9c9c86fe1874fe45c0e41624c07"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "214407ed140ae38015affa5f0359c742b5a71662de1bfd42d1d95b897a783199"
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
