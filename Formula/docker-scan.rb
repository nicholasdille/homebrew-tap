class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.17.0",
    revision: "061fe0a0c54762676295afce4ae5e31efd85b99b"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.17.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "63d77129fdd9f67f713d02a5cf7e0dfb01c9adc20f9dfb49ae8e63c77b25e715"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "28e0c2ecd3e5f83a357d32d0272c034508130261ea4d68e3b9fd345b8446dd99"
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
