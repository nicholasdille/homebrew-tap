class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v2.0.0-beta.4",
    revision: "6bfdfa8947310deee203ccb6688267a3cbdab056"
  license "Apache-2.0"
  revision 1
  head "https://github.com/docker/compose-cli.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-2.0.0-beta.4"
    sha256 cellar: :any_skip_relocation, catalina:     "5bed21ff2fde0c6d3483a479a191d31836c9a5d7a45cc93c4b6e5acd4082506e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "559aaee35d7e57acabca1a5d88143bde8de3f8a4b316c07c30e1ad1651cd0fba"
  end

  depends_on "go" => :build
  depends_on "docker"

  conflicts_with "docker-compose"

  def install
    pkg = "github.com/docker/compose-cli"
    tag = Utils.safe_popen_read("git", "describe", "--tags", "--match", "v[0-9]*")
    ENV["CGO_ENABLED"] = "0"

    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", lib/"docker/cli-plugins/docker-compose-cli",
      "./cli"

    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", lib/"docker/cli-plugins/docker-compose",
      "./cmd"

    (bin/"com.docker.cli").write <<~EOS
      #!/usr/bin/env bash
      exec #{HOMEBREW_PREFIX}/bin/docker "$@"
    EOS
  end

  def caveats
    <<~EOS
      You should create a symlink to enable the Docker CLI plugin:

      mkdir -p $HOME/.docker/cli-plugins
      ln -s #{lib}/docker/cli-plugins/docker-compose $HOME/.docker/cli-plugins
    EOS
  end

  test do
    system lib/"docker/cli-plugins/docker-compose", "compose", "version"
  end
end
