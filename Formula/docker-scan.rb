class DockerScan < Formula
  desc "CLI to run vulnerability detection on your Dockerfiles and Docker images"
  homepage "https://github.com/docker/scan-cli-plugin"

  url "https://github.com/docker/scan-cli-plugin.git",
    tag:      "v0.11.0",
    revision: "c8da19f00166f991f6f96f9e52e1174d20e43286"
  license "Apache-2.0"
  head "https://github.com/docker/scan-cli-plugin.git",
    branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-scan-0.11.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "f4b3287e524418306cdfb28bad2130fc8f513ba688993e8725ade187685e3c52"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "dfc85c19b10c712dc16642f3e6a688103c4b3bbc944b82d6e0e7b49f0daa6bc6"
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
