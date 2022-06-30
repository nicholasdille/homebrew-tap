class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.29.2",
    revision: "6b515bc73632e08a2d8d6d1bb9b8bea108c41fbe"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.29.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "3c32eaddfa73718a9675af90b6c4f55d8f2b65e70fffd274b041745fb81fb7ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c35125dec33f540b4016bd9fb4f61b833ff18bbd14a6fee972dfc5c887b3da3b"
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
