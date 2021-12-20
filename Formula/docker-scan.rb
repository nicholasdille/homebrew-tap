class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.13.0",
    revision: "e0c7c4e3a4d5fdc3ef3877fd62958a6e4b96ff02"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.13.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7efe4e2656adb13f9449cf37908a904543ffa15656be2e58ef0ccd99b861b83d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4afb143680457588a22b822fcfabe97f4e3d8000312fc64f348b931c3e58a015"
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
