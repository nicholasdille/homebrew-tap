class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.25.3",
    revision: "d4e3df81e856ac682cb9adec2ea8d1011262775f"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.25.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "16f46881d656006ab1dbb042d4617cfeeace1b0d50a8d3209451ed841ec0acee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b7e9446afd8ab80183d99aceb6d4dc2cb3607a7e46f41a783b6e0ff28241363a"
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
