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
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.6.0"
    sha256 cellar: :any_skip_relocation, big_sur:      "2e853c140906764909c0401d48235da89e75990077eb682f5393e70d79c74592"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f731fd5ff1cddfb571aa80c882150e2036888754c78e0f55bfc8c2c2b11a531e"
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
