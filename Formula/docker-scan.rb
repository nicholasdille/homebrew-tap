class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.7.0",
    revision: "0b3c5646aba8e45226ddd0c4399450cf66e69fd6"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.7.0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d40c184049abd81c57d1c3db87379d4268624dc0b196859a5f71a2f84388d6b3"
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
