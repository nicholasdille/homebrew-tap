class Trivy < Formula
  desc "Simple and comprehensive vulnerability scanner for containers suitable for CI"
  homepage "https://github.com/aquasecurity/trivy"

  url "https://github.com/aquasecurity/trivy.git",
    tag:      "v0.19.2",
    revision: "f3f302901476663b3edef629f5915236cce98bd4"
  license "Apache-2.0"
  head "https://github.com/aquasecurity/trivy.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/trivy-0.19.1"
    sha256 cellar: :any_skip_relocation, catalina:     "115585449ae9f779ebd7df82619082048c48e85df559f5567b8203e77ba46f3d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1bafbef4ab3c824efcacce627c55c9c4fac6532b27253b7c6630c684f31c74e3"
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
