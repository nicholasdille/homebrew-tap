class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.17.2",
    revision: "415e1d8ea3832b3f1807884b7c969b4d030d8098"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.17.0"
    sha256 cellar: :any_skip_relocation, catalina:     "f5831863ba0f0068250795164599d0f38885b8b6fa4bd9a4ee1f9115a2860149"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "40490e3df879e305d6a1e09ba955d1b9ba67dbedd8566aadb5da0c17ecff7379"
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
