class DockerCompose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
  tag:      "v2.2.3",
  revision: "6dc6bedb60d486691a4b53e0b88273b978523786"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.2.2"
    sha256 cellar: :any_skip_relocation, big_sur:      "932daeea7a4a773a9ce3ec9cd8283a9898cce387da46ca48e134ae051d3d4315"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c8a2505fa9f824ef43dfcdaa0f4cd1cd7703d5a271a75407e156d0f66252675c"
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
