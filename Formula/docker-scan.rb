class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.9.0",
    revision: "b05830defa878f9fce45256f665c2fb3de48ca03"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.8.0"
    sha256 cellar: :any_skip_relocation, catalina:     "2aae10971a86ebdd3698234185951eb464787e47888c219fd3cf7128988b6871"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "156625177f3cd986ce23f887997a7e31d96d55ba3e5a1bbeb62b9d3a69fbd487"
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
