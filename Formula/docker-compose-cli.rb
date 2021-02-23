class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v1.0.7",
    revision: "4a4e6be1cbf9fa1b5a5935f0676e87a50ca66e23"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    system "make", "-f", "builder.Makefile", "cross"
    bin.install "bin/docker-linux-amd64" => "compose-cli"

    # TODO: ~/.docker/cli-plugins/docker-compose
    (buildpath/"docker-compose").write <<~EOS
      #!/usr/bin/env bash
      # https://gist.github.com/thaJeztah/b7950186212a49e91a806689e66b317d
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
              if [ -x "$(command -v docker-cli-compose)" ]; then
                  exec docker-cli-compose "$@"
              else
                  exec "docker-$@"
              fi
             ;;
      esac
    EOS

    # TODO: ln -s /usr/bin/docker ~/bin/com.docker.cli
  end

  test do
    system "docker", "compose", "--version"
  end
end
