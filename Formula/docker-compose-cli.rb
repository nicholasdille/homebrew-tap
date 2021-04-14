class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v1.0.13",
    revision: "a95806712ade3a8f46c2c625f2f38974978080db"
  license "Apache-2.0"
  head "https://github.com/docker/compose-cli.git"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-1.0.13"
    sha256 cellar: :any_skip_relocation, catalina:     "36acec188d5e5d6aaef960622c02559863aca96b628785a956c961994e548148"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d957882f8baca23bf88628215a142fe508190339ead7965a00dd67ce341ade59"
  end

  depends_on "go" => :build

  conflicts_with "docker-compose"

  def install
    tag = Utils.safe_popen_read("git", "describe", "--tags", "--match", "v[0-9]*")
    ENV["CGO_ENABLED"] = "0"
    system "go",
      "build",
      "-trimpath",
      "-ldflags", "-s -w"\
                  " -X github.com/docker/compose-cli/internal.Version=#{tag}",
      "-o", bin/"docker-compose-cli",
      "./cli"

    (lib/"docker/cli-plugins/docker-compose").write <<~EOS
      #!/usr/bin/env bash

      docker_cli_plugin_metadata() {
          if [ -z "$DOCKER_COMPOSE_VERSION" ]; then
              export DOCKER_COMPOSE_VERSION="$(docker-compose --version | cut -d " " -f 3 | cut -d "," -f 1)"
          fi
          local vendor="Docker"
          local url="https://www.docker.com"
          local description="Define and run multi-container applications"
          cat <<-EOF
      {"SchemaVersion":"0.1.0","Vendor":"${vendor}","Version":"${DOCKER_COMPOSE_VERSION}","ShortDescription":"${description}","URL":"${url}"}
      EOF
      }

      case "$1" in

          docker-cli-plugin-metadata)
              docker_cli_plugin_metadata
              ;;

          *)
              if [ -x "$(command -v docker-compose-cli)" ]; then
                  exec docker-compose-cli "$@"
              else
                  exec "docker-$@"
              fi
             ;;

      esac
    EOS

    (bin/"com.docker.cli").write <<~EOS
      #!/usr/bin/env bash
      exec docker "$@"
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
    system "whereis", "docker-compose-cli"
  end
end
