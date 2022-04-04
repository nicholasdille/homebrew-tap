class Buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://www.docker.com"

  url "https://github.com/docker/buildx.git",
    tag:      "v0.8.2",
    revision: "6224def4dd2c3d347eee19db595348c50d7cb491"
  license "Apache-2.0"
  head "https://github.com/docker/buildx.git",
    branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildx-0.8.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "0883be73b14095c10544cfccd4ca2046e89c9a67f6fb2f0a7dd0f5692229aea8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ac69564d6196a8c31b96cb597f4d1639be0c647f677f6f61d5bc2258c6f50910"
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
