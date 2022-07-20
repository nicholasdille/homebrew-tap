class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.30.1",
    revision: "9da45f7bbdb291eb70cd91d8872c5afbaeb1b6ef"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.30.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "6c7db03734fdd1f4d9368c5a3bae4b91f656593f476bcadafe2de9586aba9a60"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "10e8c62b77cf617f4f27a60d0c68148dedb4221bce1a531ab149e5e97b225efc"
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
