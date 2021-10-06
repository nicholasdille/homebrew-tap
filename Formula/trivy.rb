class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.20.0",
    revision: "f12446d3ba26b89f5c443abcd5aee2bad2dea1c8"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.19.2"
    sha256 cellar: :any_skip_relocation, catalina:     "f06341e57026b8938cff442171899130137a5ffa4f27d901e1b23be29ed6c983"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0603e566421cacf25ca8834a77bb867de4623b49c9f7b04782751301109424d2"
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
