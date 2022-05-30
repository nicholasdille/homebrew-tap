class DockerCompose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
  tag:      "v2.6.0",
  revision: "6756732fe45285f61d459809c36eed0f28fdd58b"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.5.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "791473af6f716c8f98efb8a188ef8e59d66b6762d86f28536dcd65234d80d8be"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ed064794dd97dfb78b3accbe04bfeba57f237a2542b0f1eeabcab6c5a0f2dbbf"
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
