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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-2.0.0-beta.4_1"
    sha256 cellar: :any_skip_relocation, catalina:     "f3c1f4b029c5c29f1e0bfa58c02b1b71371d29f26a66b9d9e149b137dbf98904"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "148dbc1da713ff2d9591ceb6b3e1c497ddffba8c5227401525e36a4e788c9278"
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
