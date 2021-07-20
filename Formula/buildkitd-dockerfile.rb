class BuildkitdDockerfile < Formula
  desc "Dockerfile frontend for BuildKit"
  homepage "https://github.com/moby/buildkit"

  url "https://github.com/moby/buildkit.git",
    tag:      "dockerfile/1.3.0",
    revision: "c8bb937807d405d92be91f06ce2629e6202ac7a9"
  license "Apache-2.0"
  head "https://github.com/moby/buildkit.git"

  livecheck do
    url :stable
    regex(%r{^dockerfile/(\d+\.\d+\.\d+)$}i)
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildkitd-dockerfile-1.3.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "85eea86d14ae13d8324cfa1fc4fccbdb43cfbc2ac58144ee66ffbfdeae341d46"
  end

  depends_on "go" => :build
  depends_on :linux
  depends_on "nicholasdille/tap/buildkitd"

  def install
    pkg = "github.com/moby/buildkit/frontend/dockerfile/cmd/dockerfile-frontend"
    commit = Utils.git_short_head

    ENV["CGO_ENABLED"] = "0"
    system "go", "build",
      "-ldflags", "-d -X main.Version=#{version} -X main.Revision=#{commit} -X main.Package=#{pkg}",
      "-tags", "netgo static_build osusergo",
      "-o", bin/"dockerfile-frontend",
      "./frontend/dockerfile/cmd/dockerfile-frontend"
  end

  test do
    system bin/"dockerfile-frontend", "-version"
  end
end
