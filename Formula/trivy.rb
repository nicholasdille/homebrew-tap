class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.23.0",
    revision: "449add24af3a2ef8d1f19a32d282001cc425c7c9"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.22.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "13104b07f17fab8b019bc5dc5005ac78c6847d372daa6e6ab131de87f41d71b9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "619d42fac458579680d8b35d0fc51a57c6710019f5d589aacaa72a3a4b2c4694"
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
