class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.24.3",
    revision: "4b8bf874d88172635bc329554e35de29722bb139"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.24.3"
    sha256 cellar: :any_skip_relocation, big_sur:      "cb357e3bd004a05ebe0394a6a671d2e7a5fceba8bbe35867c633651246c6131d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9cc0446a11935366dd13a5d39c2be01f321870bb2e665181e57bed1731b1d900"
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
