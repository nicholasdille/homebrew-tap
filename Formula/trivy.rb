class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.17.2",
    revision: "415e1d8ea3832b3f1807884b7c969b4d030d8098"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.17.2"
    sha256 cellar: :any_skip_relocation, catalina:     "31dbae5a9cf87d4e3bf7957f15fe6049cc6cb0321a1cc4ef2e647e6830378339"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cb790dea2bfa6b351fe7d1dc5c7ef66a35b53c100efa5088e794eff48dd80381"
  end

  depends_on "git" => :build
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
