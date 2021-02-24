class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v1.0.7",
    revision: "4a4e6be1cbf9fa1b5a5935f0676e87a50ca66e23"
  license "Apache-2.0"

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-1.0.7"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ab03f8811f113e36254d4343b833f2f5657e3cec55aea8f1eaaf4df6d1a9b17c"
  end

  depends_on "go" => :build
  depends_on "docker"

  conflicts_with "docker-compose"

  def install
    system "make", "-f", "builder.Makefile", "cross"
    bin.install "bin/docker-linux-amd64" => "docker-compose-cli"

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
    system "docker", "compose", "--help"
  end
end
