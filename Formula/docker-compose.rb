class DockerCompose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
  tag:      "v2.1.1",
  revision: "e6599c7213f70b0a47b410450394c07e0b0245c9"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "b2539b6a7b727a659f57a1fb2c9ddce2d08bfc8a7558bafc683576de855f8ced"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b21ac3e78e22fdc33dca20265ce84427218ba519730f680296569f8322097656"
  end

  depends_on "go" => :build
  depends_on "docker" => :optional
  conflicts_with "nicholasdille/tap/docker-compose-bin"

  def install
    pkg = "github.com/docker/compose/v2"
    ENV["CGO_ENABLED"] = "0"

    system "go",
        "build",
        "-trimpath",
        "-tags", "e2e,kube",
        "-ldflags", "-s -w"\
                    " -X #{pkg}/internal.Version=v#{version}",
        "-o", lib/"docker/cli-plugins/docker-compose",
        "./cmd"

    (bin/"com.docker.cli").write <<~EOS
      #!/usr/bin/env bash
      exec #{HOMEBREW_PREFIX}/bin/docker "$@"
    EOS

    (bin/"docker-compose").write <<~EOS
      #!/bin/bash
      exec #{lib}/docker/cli-plugins/docker-compose compose "$@"
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
