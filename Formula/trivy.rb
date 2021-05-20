class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.18.2",
    revision: "44469611670d41ca726e15d37b8a8d84993732f4"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.18.2"
    sha256 cellar: :any_skip_relocation, catalina:     "808ae6cc0aaf9f9c13cf4c5691c0d9420fa652e8d029743532b269dc67fd82b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "563c95d5edf43be03a83082fde1ba3dcf95121a3f078e40f931c7892dafb32b7"
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
