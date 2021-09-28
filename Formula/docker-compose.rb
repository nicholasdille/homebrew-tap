class DockerCompose < Formula
  desc "Define and run multi-container applications with Docker"
  homepage "https://docs.docker.com/compose/"

  url "https://github.com/docker/compose.git",
  tag:      "v2.0.0",
  revision: "7c47673d4af41d79900e6c70bc1a3f9f17bdd387"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :git
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-2.0.0"
    sha256 cellar: :any_skip_relocation, catalina:     "6ea60dc6c44d5502074d63e1183e4b07c60f713767c1cd8a173c8ac266b3010a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c5a111b13bdfb3e70e5d703d0edd58e7cd479ac3bafd5b3444e95e790e0fba79"
  end

  depends_on "go" => :build
  depends_on "docker" => :optional

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
