class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.15.0",
    revision: "08ca1b00b729b2a83c0e9f2f6e8d1a9f0110c455"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.15.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0a245cdda316d9f000660d977133221a3a2b113604594cfc118b89043854bc5"
  end

  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "describe", "--tags")
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-ldflags", "-s -w -X=main.version=#{tag}", "./cmd/trivy"
    bin.install "trivy"
  end

  test do
    system "#{bin}/trivy", "--version"
  end
end
