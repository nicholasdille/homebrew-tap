class Buildx < Formula
  desc "Docker CLI plugin for extended build capabilities with BuildKit"
  homepage "https://www.docker.com"

  url "https://github.com/docker/buildx.git",
    tag:      "v0.5.1",
    revision: "11057da37336192bfc57d81e02359ba7ba848e4a"
  license "Apache-2.0"
  revision 1
  head "https://github.com/docker/buildx.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/buildx-0.5.1_1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "900c685c5470a1633b706b2dc2287d9f6af077496a103b1f73eabd1994dd617e"
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
