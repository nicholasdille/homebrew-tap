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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildx-0.8.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "c417533646fc86051127d9cd43889d833d57a53c4c69a4bab59f71be2ff95843"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab0f1c174cdabda645b2cfe905a4e677202bd170e33cb1e964d16550f2bda39f"
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
