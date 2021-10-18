class ArtifactoryCleanup < Formula
  desc "Cleanup artifacts on Jfrog Artifactory with advanced settings"
  homepage "https://crazymax.dev/artifactory-cleanup/"

  url "https://github.com/crazy-max/artifactory-cleanup.git",
    tag:      "v1.5.0",
    revision: "05479368a3050635e03478dd744c8e6ac3b39b70"
  license "MIT"
  revision 1
  head "https://github.com/crazy-max/artifactory-cleanup.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/artifactory-cleanup-1.5.0"
    sha256 cellar: :any_skip_relocation, catalina:     "5b9ef32b59f9d748a97d9e5b32098e6bf24bbec4347709ee36d239512f0d321d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7dc8b836cabe74abd90724064db534d805d143687e5b6d7eec55d4c0b3cf5c38"
  end

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      *std_go_args(
        ldflags: "-s -w -X main.version=#{version}"
      ),
      "./cmd/main.go"
  end

  test do
    assert_match version, shell_output("#{bin}/#{name} --version")
  end
end
