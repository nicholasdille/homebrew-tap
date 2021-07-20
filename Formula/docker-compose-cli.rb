class DockerComposeCli < Formula
  desc "Easily run your Compose application to the cloud with compose-cli"
  homepage "https://github.com/docker/compose-cli"

  url "https://github.com/docker/compose-cli.git",
    tag:      "v2.0.0-beta.6",
    revision: "ed0b123b758c44de14ee4f808a8a500558bd4d32"
  license "Apache-2.0"
  head "https://github.com/docker/compose-cli.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://github.com/nicholasdille/homebrew-tap/releases/download/docker-compose-cli-2.0.0-beta.6"
    sha256 cellar: :any_skip_relocation, catalina:     "7341783748cdc815e033c1c6557664cd0e862febbe90e2bff8cd2d461d3adcb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5422fadef6a6a9536191efa04c9e039dfe5f95203bd75de0b028d063474dd966"
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
      "-tags", "e2e,kube",
      "-ldflags", "-s -w"\
                  " -X #{pkg}/internal.Version=#{tag}",
      "-o", lib/"docker/cli-plugins/docker-compose-cli",
      "./cli"

    system "go",
      "build",
      "-trimpath",
      "-tags", "e2e,kube",
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
