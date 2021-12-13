class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.12.0",
    revision: "1074dd0695bfef5cae2edccca2187e66ad400f8b"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.12.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "bfa72ca6678b8230b7e2c54f49ea64186402580178b6631a36c82fe91557f893"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e8233847b0a6bc1d103f50c6440faf4623aba863a7bd4927d257acd309d1e252"
  end

  depends_on "go" => :build
  depends_on "make" => :build

  def install
    system "make", "-f", "builder.Makefile", "build", "PLATFORM_BINARY=docker-scan"
    bin.install "bin/docker-scan"
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{HOMEBREW_PREFIX}/bin/docker-scan $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system "whereis", "docker-scan"
  end
end
