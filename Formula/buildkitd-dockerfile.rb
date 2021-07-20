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
