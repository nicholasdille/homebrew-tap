class Buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://www.docker.com"

  url "https://github.com/docker/buildx.git",
    tag:      "v0.8.0",
    revision: "c8f7c1e93ffa9cfcf926cd3e6450af957f235b07"
  license "Apache-2.0"
  head "https://github.com/docker/buildx.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildx-0.7.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "abfa770a681c846952aa7acc84c071bb8a0934cc04b5aa1a672b2e66a9273bf7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bc94b195dc300487534bf6e55934e4332d4df19260e227c2c49cb1b7a0b718a7"
  end

  depends_on "go" => :build

  def install
    pkg = "github.com/docker/buildx"
    tag = Utils.safe_popen_read(
      "git",
      "describe",
      "--match",
      "v[0-9]*",
      "--dirty='.m'",
      "--always",
      "--tags",
    )
    revision = Utils.safe_popen_read(
      "git",
      "rev-parse",
      "HEAD",
    )
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/version.Version=#{tag}"\
                  " -X #{pkg}/version.Revision=#{revision}"\
                  " -X #{pkg}/version.Package=#{pkg}",
      "-o",
      bin/"docker-buildx",
      "./cmd/buildx"
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{HOMEBREW_PREFIX}/bin/docker-buildx $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system bin/"docker-buildx", "version"
  end
end
