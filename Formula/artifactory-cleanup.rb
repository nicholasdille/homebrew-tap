class ArtifactoryCleanup < Formula
  desc "Cleanup artifacts on Jfrog Artifactory with advanced settings"
  homepage "https://crazymax.dev/artifactory-cleanup/"

  url "https://github.com/crazy-max/artifactory-cleanup.git",
    tag:      "v1.5.0",
    revision: "05479368a3050635e03478dd744c8e6ac3b39b70"
  license "MIT"
  head "https://github.com/crazy-max/artifactory-cleanup.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X main.Version=#{version}",
      "-o", bin/"artifactory-cleanup",
      "./cmd/main.go"
  end

  test do
    system bin/"artifactory-cleanup", "--version"
  end
end
