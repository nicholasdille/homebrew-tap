class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.30.3",
    revision: "fa8a8ba7dc819c502b77f272ff0c239dcff7d9f3"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.30.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "bf64bf188969d9a8e6408dbd36e3ce006aa907c755ad5cca333181819f617201"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d2ed0e7e8ac72f05ddc6f7c45a077bee6f934215bd5b142c769f4057a9baaa30"
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
