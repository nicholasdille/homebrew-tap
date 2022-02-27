class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.24.1",
    revision: "a423b9931295cd5bf6cb0019ad15fa89a20ea71d"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.24.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "a928b281f940bd91fce47e4bb5a2f14d0d14f5b525f5decbdb9d66587bad2dc7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7f682d208780a3e02a2717feb2b1e77363e53cdd0698e902d7c6ef8062859dbf"
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
