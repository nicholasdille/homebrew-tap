class DockerCompose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
  tag:      "v2.4.1",
  revision: "8d815ff587d7d5da90835a5007859edb9fafff61"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.4.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "7cb48c93ac3e5e3725f0f00860f85d74fd46987a929ff0cffd41a74f96199941"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "be7c0f85bd3690cb36700dc22acb44c2825aa05e08211c6caeccc5c5c1d86198"
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
