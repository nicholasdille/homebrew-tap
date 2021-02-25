class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.15.0",
    revision: "08ca1b00b729b2a83c0e9f2f6e8d1a9f0110c455"
  license "Apache-2.0"
  revision 1
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.15.0_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ccac6a2e7b174d716aa683717d0d1eff39ef35625d87d4de8137d48de27219fe"
  end

  depends_on "go" => :build

  def install
    tag = Utils.safe_popen_read("git", "describe", "--tags")
    ENV["GO111MODULE"] = "on"
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags",
      "-s -w -X=main.version=#{tag}",
      "-o",
      "#{bin}/trivy",
      "./cmd/trivy"
  end

  test do
    system "#{bin}/trivy", "--version"
  end
end
