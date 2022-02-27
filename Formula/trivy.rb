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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.24.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "8d3750f17fa9606e7d56fa739912cc211cdbf01ac700acfe88d77e0dcaf9f330"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ba4d2f4c32e9bd097ad7d999fba016b3839517f109fcf53e120a612fbb1e37e4"
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
