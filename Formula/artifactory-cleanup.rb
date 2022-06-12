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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/artifactory-cleanup-1.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "5c8846e8f9b31c0267fab13dec812ae54c487a35f68a42225a15764ff1f1d5e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9df17acb4ce67e9960eeb997f514414528c7618bfd584cacf9c776b17301b607"
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
