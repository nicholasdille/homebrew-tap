class ArtifactoryCleanup < Formula
  desc "Cleanup artifacts on Jfrog Artifactory with advanced settings"
  homepage "https://crazymax.dev/artifactory-cleanup/"

  url "https://github.com/crazy-max/artifactory-cleanup.git",
    tag:      "v1.6.0",
    revision: "5099bf5609f769d3c0f7732140c9e3941a1239d0"
  license "MIT"
  head "https://github.com/crazy-max/artifactory-cleanup.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/artifactory-cleanup-1.5.0_1"
    sha256 cellar: :any_skip_relocation, big_sur:      "6bdef84eb46c6e85cf45570b8e0d0ba8cdf5cc9464179467152a5f0b9c1469f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "739d897b2d4b90dc084e11b0df7edad52aff08591b4e0a98107c77aff7b27ae2"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      *std_go_args(ldflags: "-s -w -X main.version=#{version}"),
      "./cmd/main.go"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/#{name} --version")
  end
end
